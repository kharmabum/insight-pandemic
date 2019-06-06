# Insight DE.SV.2019 Project Proposal
- [Slides](https://docs.google.com/presentation/d/1vkE3Ajv-h3oT1M7pjeYCO7HaXr5QjviyjIslqmHGm5I/edit?usp=sharing)

## Project Idea

Epidemics require near real-time response to existing and emerging threats. In the event of a pandemic, a response must be coordinated on a global scale. To this end, public health surveillance systems (PHSS) must meet numerous and evolving objectives (e.g. outbreak detection, intervention monitoring), ingest a variety of data sources (e.g. patient records, death certificates, lab test orders), meet elevated security guarantees as regulated by law, support analytical workflows, and provide actionable insights.

This project will demonstrate an extensible, standards-based platform for ingesting, processing, and storing events that could be deployed as part of a PHSS. The system will automatically detect the creation of a new event schema and in response deploy a new API endpoint and Kafka topic. Long term storage and historical analysis will be supported by delivering events to data lake in S3. Real time processing and monitoring will be provided by KSQL streaming applications that display results in a Grafana interface.


### Example Events
- Patient records
- Police reports
- Death certificates
- Drug purchases, fulfillments
- Lab test orders, lab results for notifiable diseases
- Emergency departments events or calls
- Environmental hazards (chemical or physical agents in air, water, soil, food)
- Work or school absences


## Tech Stack
- AWS Gateway (Load balancing, reverse proxy, endpoint configuration)
- Lambda (Logging, schema validation, frontend logic)
- Kafka, KSQL (Ingestion, streaming)
- S3 (Schema/query storage, data lake)
- Grafana (UI dashboard)


## Data Source
For this project I will leverage California's [Public Patient Discharge Data](https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/UBDMR6&version=1.0) (available [here](https://oshpd.ca.gov/data-and-reports/request-data/public-data/#top)) in order to simulate a stream of incoming patient records.


## Engineering Challenge
This project requires a data pipeline that is extensible in terms of both its data sources and processing capabilities. Beyond setting up critical infrastructure (API frontend, Kafka cluster, S3 data lake) the primary challenge will be automating the creation and deployment of new resources (API endpoints, Kafka topics, KSQL applications) in response to user demand.


## Business Value
The primary users of a PHSS system are health care practitioners and analysts (not software engineers). Thus having a system that automatically scales and accepts new event types and analytical queries would be appropriate and valuable. Further, PHSS systems themselves have far-reaching economic impact. The lack of a PHSS system in 2003 during the SARS outbreak resulted in an estimated reduction in real gross domestic product of more than US $1.0 billion in Canada and estimated income losses in the range of US $12.3 billion to US $28.4 billion for East and Southeast Asia as a whole (Peter Nsubuga et al, "Public Health Surveillance", https://www.ncbi.nlm.nih.gov/books/NBK11770/).


##  MVP
- Gateway endpoint + Lambda function to accept records, pushing events to Kafka
- Kafka cluster with single patient_record topic
- Kafka consumer/connector to S3 archival storage
- KSQL application generating a symptom_alert
- Grafana dashboard displaying symptom_alert
- Automating new endpoint and topic creation, triggered by addition to schema registry
- Automating new KSQL application deployment, triggered by addition to query registry


## Stretch Goals
- Security audit: to meet minimum regulatory requirements, data stored and in-transit should be secured at all times via encryption, client authentication, and policy-based, fine-grained access control.
- Containerization: using Docker (or some other image/container deployment strategy) would improve maintainability of the system.
- Bulk ingestion and batch processing: a PHSS must often import data from a number of static sources including disease registries, census data, annual health surveys, and administrative data systems (e.g. hospital discharge data) that are useful for monitoring public health and arrive in a variety of bulk formats.
- Schema validation: prior to deployment, new event schemas ought to be validated to ensure data types are supported and fields match conventions. In the case of an invalid schema, helpful error messages ought to be provided.
- Query validation: prior to deployment, new queries ought to be validated to ensure appropriate resources (e.g. tables/topics) are available. In the case of an invalid query, helpful error messages ought to be provided.
- Predictive, real-time analytics: the system architecture supports adding a machine learning pipeline and exposing incoming data to a trained model.
- Real-time SMS/email alerts: user-provided KSQL queries that naturally translate to critical incidents should be able to deliver targeted alerts to users of the system.
- Spatial and location data: tracking and visualizing a geo-spatial component of events would be useful for monitoring geographical trends.


