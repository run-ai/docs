# <span>Why?</span>

<span>Some Docker images are stored in private docker registries. In order for the researcher to access the images, we will need to provide credentials for the registry.</span>

# <span>How?</span>

<span>For each private registry you must perform the following&nbsp;</span><span>(The example below uses Docker Hub):</span>

<pre><span>kubectl create secret docker-registry &lt;secret_name&gt; -n runai \ <br/>--docker-server=https://index.docker.io/v1/ \<br/>--docker-username=&lt;user_name&gt; --docker-password=&lt;password&gt;<br/></span><span></span><br/>kubectl label secret &lt;secret_name&gt; runai/cluster-wide="true" -n runai<span></span><span></span></pre>

*   <span class="c-mrkdwn__br" data-stringify-type="paragraph-break">_secret-name_&nbsp;may be any arbitrary string. </span>
*   <span class="c-mrkdwn__br" data-stringify-type="paragraph-break">_user\_name_ and _password_ are the repository user and password.&nbsp;</span><span class="c-mrkdwn__br" data-stringify-type="paragraph-break"></span>

__Note__: the secret may take up to a minute to update in the system