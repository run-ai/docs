## <span>Why?</span>

<font face="-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif">In some business scenarios, you may want to direct the Run:AI scheduler to schedule a Workload to a specific node or a node group. For example, in some academic </font>

institutions

<font face="-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif">, hardware is bought using a specific grant and thus "belongs" to a specific research group.</font>

<font face="-apple-system, BlinkMacSystemFont, Segoe UI, Helvetica, Arial, sans-serif">Run:AI allows this "taint" by labeling a node, or a set of nodes and then during scheduling, using the flag <em>--node-type &lt;label&gt;</em> to force this allocation</font>

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;"></span>

## <span>Configuring Node Groups</span>

<span>To configure a node group:</span>

*   <span>Get the names of the nodes where you want to limit Run:AI. To get a list of nodes, run:</span>

<pre><span>kubectl get nodes&nbsp;</span></pre>

*   For each node run the following:&nbsp;  
    <span class="c-mrkdwn__br" data-stringify-type="paragraph-break"></span>

<pre>kubectl label node &lt;node-name&gt; run.ai/type=&lt;label&gt;</pre>

<span>The same value can be set to a single node, or for multiple nodes.&nbsp;</span>

<span>A node can only be set with a single value</span>

## <span>Using Node Groups via the CLI</span>

<span>Use the node type label with the --node-type flag, such as:</span>

<pre><span>runai submit job1 ... --node-type "my-nodes"</span></pre>

See the runai submit [documentation](https://support.run.ai/hc/en-us/articles/360011436120-runai-submit) for further information&nbsp;

## Assigning Node Groups to a Project

To assign specific node groups to a project see:&nbsp;<https://support.run.ai/hc/en-us/articles/360011591300-Working-with-Projects>&nbsp;.&nbsp;

When the CLI flag is used in conjunction with Project-based affinity, the flag is used to refine the list of allowable node groups set in the project