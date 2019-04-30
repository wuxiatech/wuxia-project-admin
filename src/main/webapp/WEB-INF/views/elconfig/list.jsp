<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/common/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>字典列表</title>
    <style type="text/css">
        label {
            font-size: 14px;
        }
    </style>
    <mycss>
        <link rel="stylesheet" href="//ace.zjcdn.cn/assets/css/ui.jqgrid.css"/>
    </mycss>
</head>
<body>

<div class="row">
    <div class="col-xs-12">
        <div class="header smaller lighter blue" id="buttons">
            <button data-href="/dynamic-config/create" class="btn-u btn-u-blue">新增规则</button>
            <button data-href="/dynamic-config/flushcache/1" data-alert="确定清除头条api全量缓存？" data-async="true" class="btn-u btn-u-blue">清除头条api动态配置全量缓存</button>
            <button data-href="/dynamic-config/flushcache/3" data-alert="确定清除清理大师api全量缓存？" data-async="true" class="btn-u btn-u-blue">清除清理大师api动态配置全量缓存</button>
        </div>
        <%--<div class="table-responsive">--%>
            <%--<table class="table table-hover table-bordered table-striped">--%>
                <%--<thead>--%>
                <%--<tr>--%>
                    <%--<th>描述</th>--%>
                    <%--<th>规则</th>--%>
                    <%--<th>值</th>--%>
                    <%--<th>应用名称</th>--%>
                    <%--<th>有效期</th>--%>
                    <%--<th>操作</th>--%>
                <%--</tr>--%>
                <%--</thead>--%>
                <%--<tbody>--%>
                <%--<c:forEach items="${list }" var="config">--%>
                    <%--<tr>--%>
                        <%--<td>${config.name }</td>--%>
                        <%--<td>${config.express}</td>--%>
                        <%--<td>${config.value}</td>--%>
                        <%--<td>--%>
                            <%--<c:forEach items="${appids}" var="appid">--%>
                                <%--<c:if test="${appid.id == config.appid}">${appid.displayName}</c:if>--%>
                            <%--</c:forEach>--%>
                        <%--</td>--%>
                        <%--<td><fmt:formatDate value="${config.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/>至<fmt:formatDate value="${config.expirytime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>--%>
                        <%--<td><a href="/dynamic-config/edit/${config.id}" class="btn btn-success btn-xs">修改</a>--%>
                            <%--&lt;%&ndash;<a href="/dynamic-config/del/${config.id}" class="btn btn-info btn-xs">删除</a>&ndash;%&gt;--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                <%--</c:forEach>--%>
                <%--</tbody>--%>
            <%--</table>--%>
        <%--</div>--%>

        <div class="col-xs-12">
            <!-- PAGE CONTENT BEGINS -->

            <table id="grid-table"></table>

            <div id="grid-pager"></div>

            <script type="text/javascript">
                var $path_base = "/";//this will be used in gritter alerts containing images
            </script>

            <!-- PAGE CONTENT ENDS -->
        </div><!-- /.col -->

    </div>
</div>
<myjs>
    <script src="//ace.zjcdn.cn/assets/js/jqGrid/jquery.jqGrid.min.js"></script>
    <script src="//ace.zjcdn.cn/assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
    <script>
        jQuery(function ($) {
            var grid_selector = "#grid-table";
            var pager_selector = "#grid-pager";

            jQuery(grid_selector).jqGrid({
                //direction: "rtl",

                url: '/dynamic-config/listdata',
                datatype: "json",
                height: 400,
                colNames: ['ID', '描述', 'key', '规则', '值', '应用', '有效期', '状态', '操作'],
                colModel: [
                    {
                        name: 'id',
                        index: 'id',
                        hidden: true
                    },
                    {name: 'name', index: 'name', width: 90},
                    {
                        name: 'code',
                        index: 'code',
                        //searchoptions: {sopt: ['eq']},
                        width: 150, sortable: false
                    },
                    {name: 'express', index: 'express', width: 90},
                    {name: 'value', index: 'value', width: 120, search:false},
                    {
                        name: 'appid',
                        index: 'appid',
                        width: 90, formatter: whichApp,
                        stype: 'select', searchoptions: {value: {"":"所有","1": '头条', "2": '小说', "3": '清理'},defaultValue:''}
                    }, {
                        name: 'starttime',
                        index: 'starttime',
                        search: false,
                        width:200,
                        formatter: function (cellvalue, options, cell) {
                            var rstr = "";
                            if(cell.starttime){
                                rstr += cell.starttime + ' 至 ';
                            }
                            if(cell.expirytime) {
                                rstr += cell.expirytime;
                            }else{
                                rstr+="长期"
                            }
                            return rstr;
                        }
                    },
                    {
                        name: 'status',
                        index: 'status',
                        search: false,
                        width: 50, formatter: status,
                        //stype: 'select', searchoptions: {value: {"":"所有","true": '正常', "false": '禁用'},defaultValue:''}
                    }, {
                        name: '',
                        index: '',
                        search: false,
                        width: 50,
                        formatter: function (cellvalue, options, cell) {
                            return "<a href=\"/dynamic-config/edit/" + cell.id + "\">修改</a>";
                        }
                    }
                ],

                viewrecords: true,
                rowNum: 15,
                rowList: [15, 30, 50],
                pager: pager_selector,
                altRows: true,
                //toppager: true,

                multiselect: false,
                //multikey: "ctrlKey",
                multiboxonly: true,

                loadComplete: function () {
                    var table = this;
                    setTimeout(function () {
                        //styleCheckbox(table);

                        updateActionIcons(table);
                        updatePagerIcons(table);
                        enableTooltips(table);
                    }, 0);
                },

                editurl: $path_base + "/dummy.html",//nothing is saved
                caption: "动态配置",


                autowidth: true,
                repeatitems: false,
                jsonReader: {
                    root: "result",
                    page: "pageNo",
                    total: "totalPages",
                    records: "totalCount"
                }


            });

            //enable search/filter toolbar
            jQuery(grid_selector).jqGrid('filterToolbar', {defaultSearch: true, stringResult: true})

            //switch element when editing inline
            function aceSwitch(cellvalue, options, cell) {
                setTimeout(function () {
                    $(cell).find('input[type=checkbox]')
                        .wrap('<label class="inline" />')
                        .addClass('ace ace-switch ace-switch-5')
                        .after('<span class="lbl"></span>');
                }, 0);
            }

            //enable datepicker
            function pickDate(cellvalue, options, cell) {
                setTimeout(function () {
                    $(cell).find('input[type=text]')
                        .datepicker({format: 'yyyy-mm-dd', autoclose: true});
                }, 0);
            }

            function whichApp(cellvalue, options, cell) {
                switch (cellvalue) {
                    case '1':
                        return "头条";
                    case '2':
                        return "小说";
                    case '3':
                        return "清理";
                    default:
                        return '';
                }
            }

            function status(cellvalue, options, cell) {
                switch (cellvalue) {
                    case true:
                        return "正常";
                    case false:
                        return "禁用";
                    default:
                        return '未知';
                }
            }

            var selectedPatients = [];
            //navButtons
            jQuery(grid_selector).jqGrid('navGrid', pager_selector,
                { 	//navbar options
                    add: false, edit: false, del: false,
                    search: true,
                    searchicon: 'icon-search orange',
                    refresh: true,
                    refreshicon: 'icon-refresh green',
                    view: true,
                    viewicon: 'icon-zoom-in grey',
                },
                {},
                {},
                {},
                {
                    //search form
                    recreateForm: true,
                    afterShowSearch: function (e) {
                        var form = $(e[0]);
                        form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
                        style_search_form(form);
                    },
                    afterRedraw: function () {
                        style_search_filters($(this));
                    }
                    ,
                    multipleSearch: true,
                    /**
                     multipleGroup:true,
                     showQuery: true
                     */
                },
                {
                    //view record form
                    recreateForm: true,
                    beforeShowForm: function (e) {
                        var form = $(e[0]);
                        form.closest('.ui-jqdialog').find('.ui-jqdialog-title').wrap('<div class="widget-header" />')
                    }
                }
            )


            function style_edit_form(form) {
                //enable datepicker on "sdate" field and switches for "stock" field
                form.find('input[name=sdate]').datepicker({format: 'yyyy-mm-dd', autoclose: true})
                    .end().find('input[name=stock]')
                    .addClass('ace ace-switch ace-switch-5').wrap('<label class="inline" />').after('<span class="lbl"></span>');

                //update buttons classes
                var buttons = form.next().find('.EditButton .fm-button');
                buttons.addClass('btn btn-sm').find('[class*="-icon"]').remove();//ui-icon, s-icon
                buttons.eq(0).addClass('btn-primary').prepend('<i class="icon-ok"></i>');
                buttons.eq(1).prepend('<i class="icon-remove"></i>')

                buttons = form.next().find('.navButton a');
                buttons.find('.ui-icon').remove();
                buttons.eq(0).append('<i class="icon-chevron-left"></i>');
                buttons.eq(1).append('<i class="icon-chevron-right"></i>');
            }

            function style_delete_form(form) {
                var buttons = form.next().find('.EditButton .fm-button');
                buttons.addClass('btn btn-sm').find('[class*="-icon"]').remove();//ui-icon, s-icon
                buttons.eq(0).addClass('btn-danger').prepend('<i class="icon-trash"></i>');
                buttons.eq(1).prepend('<i class="icon-remove"></i>')
            }

            function style_search_filters(form) {
                form.find('.delete-rule').val('X');
                form.find('.add-rule').addClass('btn btn-xs btn-primary');
                form.find('.add-group').addClass('btn btn-xs btn-success');
                form.find('.delete-group').addClass('btn btn-xs btn-danger');
            }

            function style_search_form(form) {
                var dialog = form.closest('.ui-jqdialog');
                var buttons = dialog.find('.EditTable')
                buttons.find('.EditButton a[id*="_reset"]').addClass('btn btn-sm btn-info').find('.ui-icon').attr('class', 'icon-retweet');
                buttons.find('.EditButton a[id*="_query"]').addClass('btn btn-sm btn-inverse').find('.ui-icon').attr('class', 'icon-comment-alt');
                buttons.find('.EditButton a[id*="_search"]').addClass('btn btn-sm btn-purple').find('.ui-icon').attr('class', 'icon-search');
            }

            function beforeDeleteCallback(e) {
                var form = $(e[0]);
                if (form.data('styled')) return false;

                form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                style_delete_form(form);

                form.data('styled', true);
            }

            function beforeEditCallback(e) {
                var form = $(e[0]);
                form.closest('.ui-jqdialog').find('.ui-jqdialog-titlebar').wrapInner('<div class="widget-header" />')
                style_edit_form(form);
            }


            //it causes some flicker when reloading or navigating grid
            //it may be possible to have some custom formatter to do this as the grid is being created to prevent this
            //or go back to default browser checkbox styles for the grid
            function styleCheckbox(table) {
                /**
                 $(table).find('input:checkbox').addClass('ace')
                 .wrap('<label />')
                 .after('<span class="lbl align-top" />')


                 $('.ui-jqgrid-labels th[id*="_cb"]:first-child')
                 .find('input.cbox[type=checkbox]').addClass('ace')
                 .wrap('<label />').after('<span class="lbl align-top" />');
                 */
            }


            //unlike navButtons icons, action icons in rows seem to be hard-coded
            //you can change them like this in here if you want
            function updateActionIcons(table) {
                /**
                 var replacement =
                 {
                     'ui-icon-pencil' : 'icon-pencil blue',
                     'ui-icon-trash' : 'icon-trash red',
                     'ui-icon-disk' : 'icon-ok green',
                     'ui-icon-cancel' : 'icon-remove red'
                 };
                 $(table).find('.ui-pg-div span.ui-icon').each(function(){
						var icon = $(this);
						var $class = $.trim(icon.attr('class').replace('ui-icon', ''));
						if($class in replacement) icon.attr('class', 'ui-icon '+replacement[$class]);
					})
                 */
            }

            //replace icons with FontAwesome icons like above
            function updatePagerIcons(table) {
                var replacement =
                    {
                        'ui-icon-seek-first': 'icon-double-angle-left bigger-140',
                        'ui-icon-seek-prev': 'icon-angle-left bigger-140',
                        'ui-icon-seek-next': 'icon-angle-right bigger-140',
                        'ui-icon-seek-end': 'icon-double-angle-right bigger-140'
                    };
                $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function () {
                    var icon = $(this);
                    var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

                    if ($class in replacement) icon.attr('class', 'ui-icon ' + replacement[$class]);
                })
            }

            function enableTooltips(table) {
                $('.navtable .ui-pg-button').tooltip({container: 'body'});
                $(table).find('.ui-pg-div').tooltip({container: 'body'});
            }

            //var selr = jQuery(grid_selector).jqGrid('getGridParam','selrow');

            $("#query_submit").click(function () {
                var url = '/dynamic-config/listdata?' + $("#query_form").serialize();
                $(grid_selector).jqGrid('setGridParam', {

                    url: url

                }).trigger("reloadGrid");
            })
        });
    </script>
</myjs>
</body>
</html>