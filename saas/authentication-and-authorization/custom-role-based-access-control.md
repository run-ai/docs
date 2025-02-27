---
hidden: true
---

# Custom role-based access control

This document introduces the Custom Role-Based Access Control (RBAC) Authorization feature, which provides granular control over user permissions. This feature allows for the creation of custom roles tailored to specific organizational needs, ensuring precise access control.\
\
Key Benefits

* Enhanced Security: Custom roles limit user access to necessary resources and actions, reducing the risk of misuse.
* Improved Compliance: Custom roles aid in meeting regulatory compliance requirements by controlling access to sensitive data.
* Streamlined Operations: Custom roles simplify user management and onboarding by aligning roles with job functions.

Key Features

* Add/Edit Custom Roles:
  * Create roles with specific permissions.
  * Define accessible resources and actions for each role.
  * Manage and update custom roles.
* Disable Roles:
  * Disable roles to restrict access to specific resources or actions.
  * Maintain control over permissions without deleting roles.

Technical Details

* The feature is available via the run:ai API starting from release 2.21.
* Permissions to create/edit roles are granted to Cloud Operators and System Admins.
* A role can only be enabled/disabled if it is not currently used by an access rule.
* A disabled role cannot be assigned to a user.
* API documentation is available for reference
