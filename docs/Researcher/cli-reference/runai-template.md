## Description

Templates are a way to reduce the amount of flags required when running the command ``runai submit``. A Template is added by the administrator and is out of scope for this article. A researcher can:

*   Review list of Templates by running ``runai template list``
*   Review the contents of a specific Template by running ``runai template get <template-name>``
*   Use a Template by running ``runai submit --template <template-name>``

The administrator can also set a default Template which is always used on ``runai submit``.

## Synopsis

```
runai template get <template-name> 
runai template list
```

## Options

<template-name\> - The name of the Template to run the command on.

``runai template list`` will show the list of existing Templates.

### Global Flags

--loglevel (string)

>  Set the logging level. One of: debug | info | warn | error (default "info")

## Output

``runai template list`` will show a list of Templates. Example:

![mceclip0.png](img/mceclip0.png)

``runai template get`` to get the Template details

![mceclip1.png](img/mceclip1.png)

Use the Template:

```
runai submit my-pytorch1 --template pytorch-default
```

## See Also

See: [Configure Command-Line Interface Templates](../../Administrator/Researcher-Setup/template-config.md) on how to configure Templates.
