# Patient Injection

Backend API implemention which would allow Hemophilia patients to:

- Maintain a digital diary of their prophylactic injections.
- See their treatment adherence score.

## Getting Started

The Backend is built using [Ruby on Rails](https://rubyonrails.org/) And for API requests we used [graphql](https://graphql.org/) by using [graphql-ruby](https://graphql-ruby.org/) gem.

For Database we used [postgres](https://www.postgresql.org/).

### Prerequisites

Setup [Docker](https://www.docker.com/).

### Installing

runing docker-compose is enough:

```bash
$ docker-compose up
```

When containers are up and running you can access the backend through [localhost:3000](localhost:3000).

To access rails container you can run:

```bash
$ docker exec -it patient-injection-api bash
```

to generate data seed run:

```bash
$ docker exec -it patient-injection-api bin/rails db:seed
```

## Api Documentation

To clarify project endpoints requests details.

- Published [Postmant](https://documenter.getpostman.com/view/15636958/2s93CSpr19).

- also if you are using VSCode you can check [thunder-client](https://www.thunderclient.com/) which already added to the project and all APIs are documented.

note\* both have enviroment variables to set the `PatientApiKey` and `ApiUrl` so when changing them, it will reflected through all apis.

## Running the tests

Using [Rspec](https://rspec.info/) and all tests are under [spec/](https://github.com/MomenSaeed/patient_injection/tree/main/spec) folder.

```bash
$ docker exec -it patient-injection-api rspec
```

using [simpleCov](https://github.com/simplecov-ruby/simplecov) to generate coverage report for rails under `./coverage/index.html`.

and [Database Cleaner](https://github.com/DatabaseCleaner/database_cleaner) to clean the database before each spec.

### Code Linting

using rubocop

```bash
$ docker exec -it patient-injection-api rubocop
```

### Github CI

building CI using [github Actions](https://github.com/MomenSaeed/patient_injection/blob/main/.github/workflows/ci.yml) to run rspec and rubocop checks.

## Exposing metrics

By using [prometheus exporter](https://github.com/discourse/prometheus_exporter) but with [graphql-ruby](https://github.com/rmosolgo/graphql-ruby/blob/master/guides/queries/tracing.md#prometheus) handlers.

Run the matrics (Note\* it's working only when run command global not inside docker containers):

```bash
$ bundle exec prometheus_exporter -a lib/graphql_collector.rb
```

To access the metrcis open [http://localhost:9394/metrics](http://localhost:9394/metrics).

## Code Structure

Mainly using [Interactors](https://github.com/collectiveidea/interactor) to handle the Business logic implementation and make the code resuable as much as possible [examples](https://github.com/MomenSaeed/patient_injection/tree/main/app/interactors).

### Graphql Structure

Main Factors for grapqhl:

- [Types](https://graphql-ruby.org/type_definitions/objects.html) to define the object types which uses to draw the graph and relations between the types [injection type](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/types/injection/type.rb) example.

- [Input Types](https://graphql-ruby.org/type_definitions/input_objects.html) mainly used in mutations but also we can create spacific input type in queries like [injection input](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/types/injection/input.rb) example.

- [resolvers](https://graphql-ruby.org/fields/resolvers.html) used to handle graphql queries by adding query name and resolver to [queryType](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/types/query_type.rb) you can check list of resolver [here](https://github.com/MomenSaeed/patient_injection/tree/main/app/graphql/resolvers).

- [mutations](https://graphql-ruby.org/mutations/mutation_root.html) used to handle graphql mutations (create/update/destroy) actions, which listed in [mutationType](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/types/mutation_type.rb), and you can check mutations list [here](https://github.com/MomenSaeed/patient_injection/tree/main/app/graphql/mutations).

- [connectionType](https://graphql-ruby.org/pagination/using_connections.html) used to handle array list requests, which could handle page pagination with cursor and request data limit, we used it to handle pagination in [Patients](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/resolvers/patients/index.rb#L2) List query and [Injections](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/resolvers/injections/index.rb#L2) List query

### Features Structure

- [CreatePatient](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/mutations/create_patient.rb) in begining have to create new patient account to get `api_key` which will be used to authintecate all requests and also to be associated with injections.

- To authenticate requests we are passing header named `Patient-Api-Key` with the patient `api_key` value, to authenticate the request current patient [check](https://github.com/MomenSaeed/patient_injection/blob/main/app/controllers/concerns/authenticable_patient.rb) for more details.

- And we are checking in graphql for [resolvers](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/resolvers/base_resolver.rb#L6) and [mutations](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/mutations/base_mutation.rb#L11) if the `current_patient` exists or not, also already added [PatientGrapqhlContext](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/patient_context.rb) to manage patient sessions.

- when `api_key` isn't valid we raise [unauthorized](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/patient_injection_schema.rb#L43-L52) field. (the only request which not have authentication check is [createPatient](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/mutations/base_mutation.rb#L7))

- using `api_key` header and `current_patient` object we could get the patient and use it direct like what we did in [createInjection](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/mutations/create_injection.rb#L6)

### Adherence Stats and Graph

Goal:

- user will send `start_date`(default is Patient created_at day) and `end_date`(default is Date of today).
- user is requeried to send `treatment_schedule` value in the request to calculate the adherence
- Get Graph with days and for each day has the info if patient already `had_injection_record` or this day is an `expected_injection` and he have to take injection on this day.
- After we got this info we can calculatethe Adherence stats and get the score.

adding resolver [request](https://github.com/MomenSaeed/patient_injection/blob/main/app/graphql/resolvers/adherence_score.rb)

#### GraphGeneration

- by going through the days between the start and end dates and on each date we check patient injection stats, check [this](https://github.com/MomenSaeed/patient_injection/blob/main/app/interactors/adherence/injections_graph.rb#L18-L20) example.

#### Score Generation

- after getting the graph we could calculate the stats and score like [here](https://github.com/MomenSaeed/patient_injection/blob/main/app/interactors/adherence/score.rb#L13-L16).

#### Score Generation

- after getting the graph we could calculate the stats and score like [here](https://github.com/MomenSaeed/patient_injection/blob/main/app/interactors/adherence/score.rb#L13-L16).

- check adherence [types](https://github.com/MomenSaeed/patient_injection/tree/main/app/graphql/types/adherence)

```bash
example input
{
  "startDate": "25-2-2023",
  "endDate": "3-03-2023",
  "treatmentSchedule": 3
}
```

```bash
example output
{
    "data": {
        "adherenceScore": {
            "adherenceScore": 50,
            "expectedInjection": 2,
            "actualInjection": 2,
            "onTimeInjection": 1,
            "injectionsGraph": [
                {
                    "date": "2023-02-25",
                    "day": 25,
                    "month": "Feb",
                    "year": 2023,
                    "weekDay": "Sat",
                    "expectedInjection": false,
                    "hasInjection": false
                },
                {
                    "date": "2023-02-26",
                    "day": 26,
                    "month": "Feb",
                    "year": 2023,
                    "weekDay": "Sun",
                    "expectedInjection": true,
                    "hasInjection": false
                },
                {
                    "date": "2023-02-27",
                    "day": 27,
                    "month": "Feb",
                    "year": 2023,
                    "weekDay": "Mon",
                    "expectedInjection": false,
                    "hasInjection": true
                },
                {
                    "date": "2023-02-28",
                    "day": 28,
                    "month": "Feb",
                    "year": 2023,
                    "weekDay": "Tue",
                    "expectedInjection": false,
                    "hasInjection": false
                },
                {
                    "date": "2023-03-01",
                    "day": 1,
                    "month": "Mar",
                    "year": 2023,
                    "weekDay": "Wed",
                    "expectedInjection": true,
                    "hasInjection": true
                },
                {
                    "date": "2023-03-02",
                    "day": 2,
                    "month": "Mar",
                    "year": 2023,
                    "weekDay": "Thu",
                    "expectedInjection": false,
                    "hasInjection": false
                },
                {
                    "date": "2023-03-03",
                    "day": 3,
                    "month": "Mar",
                    "year": 2023,
                    "weekDay": "Fri",
                    "expectedInjection": false,
                    "hasInjection": false
                }
            ]
        }
    }
}
```

### Todo List

- Front-end...
