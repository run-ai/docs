## <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">Why?</span>

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">In a gradual approach for incorporating Run:AI in a research operation, it is possible that some researchers are using the system with Run:AI and some without.</span>

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">It is, therefore, possible to limit Run:AI to use specific nodes and specific GPUs within these nodes.</span>

&nbsp;

## <span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">How?</span>

<span style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;">To configure restrictions on certain nodes:</span>

*   <span>Get the names of the nodes where you want to limit Run:AI and the GPU indices inside these nodes where you want Run:AI to be&nbsp;</span><strong data-stringify-type="bold">enabled</strong><span>.&nbsp;</span><span>For example. let’s say you want Run:AI scheduling for GPUs 1 and 3 on node\_2, GPUs 0 and 2 on node\_4, and for all GPUs on every other node.</span>
*   <span class="c-mrkdwn__br" data-stringify-type="paragraph-break"></span><span>Run the following command:</span>

<pre><span>kubectl create configmap nvidia-device-plugin-config -n runai \<br/> --from-literal node_2=“1,3” --from-literal node_4=“0,2" &amp;&amp; \<br/> kubectl delete pod -n runai -l app=pod-gpu-metrics-exporter &amp;&amp; \<br/> kubectl delete pod -n runai -l name=nvidia-device-plugin-ds</span></pre>

<span class="c-mrkdwn__br" data-stringify-type="paragraph-break"></span><span>__Note__: if names of nodes contain dashes/hyphens (‘-’), they should be replaced with underscores (‘\_’) inside the command from step 2 (e.g if a node is called node-2, we will write it as node\_2 in the command)</span>