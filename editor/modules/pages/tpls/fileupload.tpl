<div class="container">
	<!-- The file upload form used as target for the file upload widget -->
	<div id="fileupload_[[id]]" action="[[action]]">
		<!-- Redirect browsers with JavaScript disabled to the origin page -->
		<noscript>JavaScript disabled</noscript>
		<!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
		<div class="row fileupload-buttonbar">
			<div class="col-lg-7">
				<!-- The fileinput-button span is used to style the file input field as button -->
				<span class="file-upload button">
					<i class="fa fa-plus"></i>
					<span>&nbsp;[[add_files]]</span>
					<input type="file" name="files[]" multiple>
				</span>
				<button type="submit" class="button start">
					<i class="fa fa-upload"></i>
					<span>&nbsp;[[start_upload]]</span>
				</button>
				<button type="reset" class="button cancel">
					<i class="fa fa-times"></i>
					<span>&nbsp;[[cancel_upload]]</span>
				</button>
				<button type="button" class="button delete">
					<i class="fa fa-trash"></i>
					<span>&nbsp;[[delete_upload]]</span>
				</button>
				<input type="checkbox" class="toggle">
				<!-- The global file processing state -->
				<span class="fileupload-process"></span>
			</div>
			<!-- The global progress state -->
			<div class="col-lg-5 fileupload-progress fade">
				<!-- The global progress bar -->
				<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
					<div class="progress-bar progress-bar-success" style="width:0%;"></div>
				</div>
				<!-- The extended global progress state -->
				<div class="progress-extended">&nbsp;</div>
			</div>
		</div>
		<!-- The table listing the files available for upload/download -->
		<table role="presentation" class="table table-striped highlight"><tbody class="files"></tbody></table>
	</div>
</div>
<!-- The blueimp Gallery widget -->
<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls" data-filter=":even">
	<div class="slides"></div>
	<h3 class="title"></h3>
	<a class="prev">‹</a>
	<a class="next">›</a>
	<a class="close">×</a>
	<a class="play-pause"></a>
	<ol class="indicator"></ol>
</div>
<!-- The template to display files available for upload -->
<script id="template-upload_[[id]]" type="text/x-tmpl">
	{% for (var i=0, file; file=o.files[i]; i++) { %}
	<tr class="template-upload fade">
		<td>
			<input class="pos" type="hidden" name="position_[[id]][{%=file.position%}]" value="{%=file.name%}">
			<input type="hidden" name="timestamp_[[id]]" value="[[timestamp]]">
		</td>
		<td>
			<span class="preview"></span>
		</td>
		<td>
			<p class="name"><span class="heading">[[name_heading]] {%=file.name%}</span></p>
			<p class="error-wrapper"><strong class="error text-danger"></strong></p>
			<br>
			<p class="name size">Processing...</p>
			<div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
				<div class="progress-bar progress-bar-success" style="width:0%;"></div>
			</div>
			<p class="name">
			{% if (!i && !o.options.autoUpload) { %}
			<button class="btn btn-primary start" disabled>
				<i class="fa fa-upload"></i> [[start_upload]]
			</button>
			{% } %}
			{% if (!i) { %}
			<button class="btn btn-warning cancel">
				<i class="fa fa-times"></i> [[cancel_upload]]
			</button>
			{% } %}
			</p>
		</td>
	</tr>
	{% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download_[[id]]" type="text/x-tmpl">
	{% for (var i=0, file; file=o.files[i]; i++) { %}
	<tr class="template-download fade sortable">
		<td>
			<i class="fa fa-hand-o-up"></i>
			<input class="pos" type="hidden" name="position_[[id]][{%=file.position%}]" value="{%=file.name%}">
			<input type="hidden" name="timestamp_[[id]]" value="[[timestamp]]">
		</td>
		<td>
			<span class="preview">
				{% if (file.thumbnailUrl) { %}
					<a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>
				{% } %}
			</span>
		</td>
		<td>
			<p class="name"><span class="heading">[[name_heading]] </span>
				{% if (file.url) { %}
					<a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
				{% } else { %}
					<span>{%=file.name%}</span>
				{% } %}
				<br />
				<input class="tit" type="text" placeholder="[[imagetitle_placeholder]]" name="title_[[id]][{%=file.position%}]" value="{%=file.title%}">
			</p>
			{% if (file.error) { %}
				<div><span class="label label-danger">Error:</span> {%=file.error%}</div>
			{% } %}
			<br>
			<p class="name"><span class="heading size">[[size_heading]] {%=o.formatFileSize(file.size)%}</span></p>
			<p class="name">
			{% if (file.deleteUrl) { %}
				<button class="btn btn-danger delete" data-type="{%=file.deleteType%}"
					data-url="{%=file.deleteUrl%}[[deleteurl]]"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
					<i class="fa fa-trash"></i> <span>[[delete_upload]]</span>
				</button>
				<input type="checkbox" name="delete" value="1" class="toggle">
			{% } else { %}
				<button class="btn btn-warning cancel">
					<i class="fa fa-times"></i>
				</button>
			{% } %}
			</p>
		</td>
	</tr>
{% } %}
</script>