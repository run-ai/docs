# Description

Templates are a way to reduce the amount of&nbsp; flags required when running the command&nbsp;_runai submit_. A template is added by the administrator and is out of scope for this article.&nbsp; A researcher can:

*   Review list of templates by running _runai template list_
*   Review the contents of a specific template by running_ runai template get &lt;template-name&gt;_
*   Use a template by running runai submit --template &lt;template-name&gt;

The administrator can also set a default template which is always used on _runai submit_&nbsp; whenever a template is __not__ specified.&nbsp;

# Synopsis

<pre>runai template get &lt;template-name&gt;<br/>runai template list</pre>

&nbsp;

# Options

&lt;template-name&gt; the name of the template to run the command on

runai template list will show the list of existing templates.&nbsp;

## Global Flags

--loglevel (string)

>  Set the logging level. One of: debug|info|warn|error (default "info")

# Output

_runai template list_ will show a list of templates. Example:

![mceclip0.png](https://support.run.ai/hc/article_attachments/360008368280/mceclip0.png)

_runai template get&nbsp;_to get the template details

_![mceclip1.png](https://support.run.ai/hc/article_attachments/360008370359/mceclip1.png)_

Use the template:

<pre>runai submit my-pytorch1 --template pytorch-default</pre>

<span style="font-size: 2.1em; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">See Also</span>

&nbsp;See:&nbsp;<https://support.run.ai/hc/en-us/articles/360011627459-Command-Line-Interface-Templates>&nbsp;on how to configure templates