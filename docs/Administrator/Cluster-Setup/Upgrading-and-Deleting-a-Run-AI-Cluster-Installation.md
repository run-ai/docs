# Upgrading a Run:AI Cluster Installation

To upgrade a Run:AI cluster installation you must get a version number from Run:AI customer support. Then, run:

<div class="c-message_kit__gutter">
<div class="c-message_kit__gutter__right" data-qa="message_content">
<div class="c-message_kit__blocks c-message_kit__blocks--rich_text">
<div class="c-message__message_blocks c-message__message_blocks--rich_text">
<div class="p-block_kit_renderer" data-qa="block-kit-renderer">
<div class="p-block_kit_renderer__block_wrapper p-block_kit_renderer__block_wrapper--first">
<div class="p-rich_text_block" dir="auto">
<pre>kubectl set image -n runai deployment/runai-operator \<br/>  runai-operator=gcr.io/run-ai-prod/operator:NEW_VERSION</pre>
<p>&nbsp;To verify that the upgrade has succeeded run:</p>
<pre>kubectl get pods -n runai</pre>
<p>and make sure that all pods are running or completed.</p>
<h1>Deleting a Run:AI Cluster Installation</h1>
<p>To delete a Run:AI Cluster installation run the following commands:</p>
<pre class="c-mrkdwn__pre" data-stringify-type="pre">kubectl delete RunaiConfig runai -n runai<br/>kubectl delete deployment runai-operator -n runai<br/>kubectl delete crd <a aria-describedby="sk-tooltip-f47e147f-1c24-4633-b287-b4d0876dd4e8" class="c-link" data-sk="tooltip_parent" href="http://runaiconfigs.run.ai/" rel="noopener noreferrer" target="_blank">runaiconfigs.run.ai</a><br/>kubectl delete namespace runai</pre>
</div>
</div>
</div>
</div>
</div>
</div>
</div>