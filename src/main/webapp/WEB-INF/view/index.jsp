
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="../common/common.jsp"%>

<html>
<head>
<%--  <script src="https://code.jquery.com/jquery-3.4.1.js"></script>--%>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.13.5/js/jquery.jqgrid.min.js"></script>
</head>

<body>
<c:url value="rest/api/v1/ruletype" var="getRuleTypes" />

<div class="" style="min-height: 600px">
  <div class="jarviswidget white-pannel" id="ap-wid-id-1" ${widgetOptions} >
    <header class="clearfix">
      <h2><strong>Rule Types</strong></h2>
      <sec:authorize access="hasAuthority('ROLE_ADMIN')">
        <div class="widget-toolbar">
          <div class="dropdown">
            <button role="button" class="btn btn-outline-primary dropdown-toggle oval-button" data-toggle="dropdown">Actions <span class="caret"></span></button>
            <ul class="dropdown-menu dropdown-menu-right">
              <li><a id="addRuleTypes">Add</a></li>
              <li><a id="editRuleTypes">Edit</a></li>
              <li><a id="deleteRuleTypes">Delete</a></li>
            </ul>
          </div>
        </div>
      </sec:authorize>
    </header>
    <!-- widget div-->
    <div>
      <div class="jarviswidget-editbox"></div>
      <div class="widget-body">
        <table id="ruleTypesTable"></table>
        <div id="ruleTypesPagDiv"></div>
      </div>
    </div>
  </div>
</div>

<script>

  jQuery("#ruleTypesTable").jqGrid({

    url : "${getRuleTypes}",
    datatype : "json",
    jsonReader : { repeatitems : true, id : "ref" },
    colNames : [ 'ID', 'Rule Type' ],
    colModel : [
      // {name : 'id', index : 'id',  hidden:true,  width : 20},
      {name : 'name', index : 'name', width : 50},
      {name : "rule", index : "rule", width : 50}
    ],
    rowNum  : 10,
    rowList : [ 10, 20, 30 ],
    height  : 150,
    pager   : "#ruleTypesPagDiv",
    viewrecords : true,
    caption : "",
    shrinkToFit:true
  });

  jQuery("#ruleTypesTable").jqGrid('navGrid', '#ruleTypesPagDiv',{search:false,add:false,edit:false,del:false});
  //jQuery("#ruleTypesTable").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false});
  <sec:authorize access="hasAuthority('ROLE_ADMIN')">
  $("#addRuleTypes").click(function(event) {
    event.preventDefault();
    var url = '${pageContext.request.contextPath}/admin/loadAddRuleType';
    loadModal(url);
  });

  $("#editRuleTypes").click(function(event) {

    event.preventDefault();
    var url = "${pageContext.request.contextPath}/admin/loadAddRuleType?edit=true&id=";
    var id = $(this).attr('id');
    var grid = jQuery("#ruleTypesTable").jqGrid();
    var rowData = grid.getGridParam('selrow');

    if(rowData){
      var item = grid.getRowData(rowData);
      loadModal(url + item.id);
      return false;
    }
    else {
      bootbox.alert('<span class="blue-circle"><i class="ion-ios-information-outline"></i></span><br> Please select a row for editing.');
    }

  });

  /* delete rule button event handler */
  $('#deleteRuleTypes').click(function (event){

    var gid = "#ruleTypesTable";
    event.preventDefault();

    processRowData(gid, '<span class="blue-circle"><i class="ion-ios-information-outline"></i></span><br> Please select a rule type for deleting.',
            function (rowData){
              var url = '${pageContext.request.contextPath}/admin/deleteRuleTypes?id='+ rowData.id ;
              bootbox.confirm("<span class='blue-circle'><i class='fa fa-trash-o'></i></span><br><h3>Delete</h3>Please confirm before deleleting rule type :" + rowData.name, function(result){
                if(result){
                  jQuery.ajax({
                    type: "POST",
                    url: url,
                    success: function (e) {
                      reloadGrid(gid);
                      successToastr('Rule Type :' + rowData.name +' has been deleted successfully');
                    },
                    complete: function (e){
                      closeloading();
                    }
                  });//end ajax.
                }//end if
              });
            });//end process row data.

  });//end button click
  </sec:authorize>
  $(window).bind('resize', function() {
    var gridId = "ruleTypesTable";
    var gridParentWidth = $('#gbox_' + gridId).parent().width();
    $('#' + gridId).jqGrid('setGridWidth',gridParentWidth);
  }).trigger('resize');

</script>
</body>
</html>