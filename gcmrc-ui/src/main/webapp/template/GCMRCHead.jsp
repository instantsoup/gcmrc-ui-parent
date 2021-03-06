<%@page import="gov.usgs.cida.path.PathUtil"%>
<%@page import="java.io.File"%>
<%@page import="gov.usgs.cida.config.DynamicReadOnlyProperties"%>
<%@page import="org.slf4j.Logger"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%!
    private static final Logger log = LoggerFactory.getLogger("package_jsp");
    protected DynamicReadOnlyProperties props = new DynamicReadOnlyProperties();

{
        try {
            File propsFile = new File(getClass().getClassLoader().getResource("application.properties").toURI());
            props = new DynamicReadOnlyProperties(propsFile);
        } catch (Exception e) {
            log.error("Could not read application.properties. Application will not function", e);
        }
    }

    private String getProp(String key) {
        return props.getProperty(key, "");
    }

%>
<%
        String vFontAwesome = getProp("version.fontawesome");
        String relPath = request.getContextPath();
        boolean development = Boolean.parseBoolean(request.getParameter("development"));
%>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta charset="utf-8"/>
<title>${param['shortName']}</title>
<meta name="title" content="${param['title']}">
<meta name="description" content="${param['description']}">
<meta name="author" content="${param['author']}">
<meta name="keywords" content="${param['keywords']}">
<meta name="publisher" content="${param['publisher']}">
<meta name="country" content="USA">
<meta name="language" content="EN">
<meta name="revised" content="${param['revisedDate']}">
<meta name="review" content="${param['nextReview']}">
<%--<meta name="expires" content="${param['expires']}">--%>

<link type="text/css" media="screen" rel="stylesheet" href="${param['relPath']}template/common.css" title="default"/>
<link type="text/css" media="screen" rel="stylesheet" href="<%= relPath %>/webjars/font-awesome/<%= vFontAwesome %>/css/font-awesome<%= development ? "" : ".min"%>.css" />
<link type="text/css" media="screen" rel="stylesheet" href="${param['relPath']}template/custom.css" title="default"/>
<link rel="alternate stylesheet" media="screen" type="text/css" href="${param['relPath']}template/none.css" title="no_style" />
<link rel="stylesheet" media="print" type="text/css" href="${param['relPath']}template/print.css" />
<%-- fix for macs --%>
<style type="text/css">
	#usgstitle p {
		padding : 4px;
	}
</style>
<%-- Additional FontAwesome styling not in base css --%>
<style type="text/css">
        .fa-wrapper {
                position: relative
        }
</style>
<script type="text/javascript" src="${param['relPath']}template/styleswitch.js"></script>
<script type="text/javascript" src="${param['relPath']}template/external.js"></script>

<% 
    String gaAccountCode = request.getParameter("google-analytics-account-code");
    String[] gaCommandList = request.getParameterValues("google-analytics-command-set");
    
    if (gaAccountCode != null && !gaAccountCode.trim().isEmpty()) { 
%>
<!-- Google Analytics Setup -->
<script type="text/javascript">
    var _gaq = _gaq || [];
    _gaq.push(['_setAccount', '<%= gaAccountCode %>']);
    _gaq.push (['_gat._anonymizeIp']);
    _gaq.push(['_trackPageview']);
    <% 
    if (gaCommandList != null && gaCommandList.length > 0) { 
        for (int commandIdx = 0;commandIdx < gaCommandList.length;commandIdx++) {
    %> 
        _gaq.push([<%= gaCommandList[commandIdx] %>]);
    <%
        }
    } 
    %>

        (function() {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var scripts = document.getElementsByTagName('script');
            var s = scripts[scripts.length-1]; s.parentNode.insertBefore(ga, s);
        })();

</script>

<% } %>

<%-- https://insight.usgs.gov/web_reengineering/SitePages/Analytics_Instructions.aspx --%>
<%-- https://insight.usgs.gov/web_reengineering/SitePages/Analytics_FAQs.aspx --%>
<% if (!development) { %>
<script type="application/javascript" src="https://www2.usgs.gov/scripts/analytics/usgs-analytics.js"></script>
<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-46435687-1', 'gcmrc.gov');
  ga('send', 'pageview');

</script>
<% } %>