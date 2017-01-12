# Distributions

The complete edition allows to quickly reach a fonctional result. But sometimes, it is necessary to optimize the loaded code, or simply don't need all the features.

To stay in the logic of providing the maximum to a project, without overload it, Synapse Cmf dispose of three additional distributions, each of theme containing a kernel of the Synapse Cmf (and its dependencies).
The choice is yours to pick the one you need, depending of the need of your project. 

| Distribution | Package composer | Features | Type de projet | Configuration |
| -------------| ---------------- | -------- | -------------- | --------------|
| [SynapseCmfBundle](https://github.com/synapse-cmf/SynapseCmfBundle) | `"synapse-cmf/synapse-cmf-bundle": "~1.0"` | Rendering engine, media librady module, programatic API | Project without backoffice, where extern interfaces are not necessarily screens (CQRSarchitectures, web services, ...) | [See](distributions/1_cmf_bundle.md) |
| [SynapseAdminBundle](https://github.com/synapse-cmf/SynapseAdminBundle) | `"synapse-cmf/synapse-admin-bundle": "~1.0"` | Includes SynapseCmfBundle, add a html interface of element management of Synapse (skeletons, media library) and the default backoffice theme | typic project fo "interface management", when some other screens will be implemented, and the contents decorated by editorialists. | [See](distributions/2_admin_bundle.md) |
| [SynapsePageBundle](https://github.com/synapse-cmf/SynapsePageBundle) | `"synapse-cmf/synapse-page-bundle": "~1.0"` | Includes SynapseAdminBundle, add a content type "Page", which represent a simple web page, manage the referencing and the tree. Also it adds one screen to the backoffice, providing creation/edition of pages. | Distribution dedicated to showcase sites or simple sites, in the purpose of evolutivity to expose other data. | [See](distributions/3_page_bundle.md) |
