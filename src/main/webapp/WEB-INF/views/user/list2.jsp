<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/layouts_admin/taglibs.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户列表</title>
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
        <!-- PAGE CONTENT BEGINS -->

        <table id="grid-table"></table>

        <div id="grid-pager"></div>

        <script type="text/javascript">
            var $path_base = "/";//this will be used in gritter alerts containing images
        </script>

        <!-- PAGE CONTENT ENDS -->
    </div><!-- /.col -->
</div><!-- /.row -->

<myjs>
    <script src="//ace.zjcdn.cn/assets/js/jqGrid/jquery.jqGrid.min.js"></script>
    <script src="//ace.zjcdn.cn/assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
    <script type="text/javascript">

        jQuery(function ($) {
            var grid_selector = "#grid-table";
            var pager_selector = "#grid-pager";

            jQuery(grid_selector).jqGrid({
                //direction: "rtl",

                url: '/news/user/listdata',
                datatype: "json",
                height: 400,
                colNames: ['ID', '昵称', '电话', '好友数', '今日收益', '可用金币', '提现次数', '注册时间', '最后登录', '最后登录IP', '状态', '注册来源', '注册版本', '注册渠道'],
                colModel: [
                    {
                        name: 'userId',
                        index: 'userId',
                        hidden: false,
                        sorttype: 'integer',
                        searchtype: 'number',
                        searchoptions: {sopt: ['eq']},
                        formatter: function (cellvalue, options, cell) {
                            return "<a target='_blank' href=\"/news/user/profile/" + cell.userId + "\">" + cell.userId + "</a>";
                        }
                    },
                    {name: 'nickName', index: 'nickName', width: 90},
                    {
                        name: 'mobile',
                        index: 'mobile',
                        searchoptions: {sopt: ['eq']},
                        width: 150, sortable: false
                    },
                     {
                        name: 'childCount',
                        index: 'childCount',
                        sorttype: 'integer',
                        search: false,
                        formatter: function (cellvalue, options, cell) {
                            if(isNotBlank(cellvalue)) {
                                return "<a href=\"/news/user/prentices/" + cell.userId + "\">" + cellvalue + "</a>";
                            }else{
                                return "0";
                            }
                        }
                    },
                    {name: 'todayTotalInCoin', index: 'todayTotalInCoin', sorttype: 'integer', search: false},
                    {name: 'availabelCoin', index: 'availabelCoin', sorttype: 'integer', search: false},
                    {name: 'withdrawCount', index: 'withdrawCount', sorttype: 'integer', search: false},
                    {name: 'createdOn', index: 'createdOn', width:210, searchoptions: {
                            dataInit: function (e) {
                                $(e).datepicker({format: 'yyyy-mm-dd', autoclose: true});
                            }, attr: {title: '选择日期'}, sopt: ['cn']
                        }, formatter: 'date', formatoptions: {srcformat: 'Y-m-d H:i:s', newformat: 'Y-m-d H:i:s'}},
                    {name: 'lastLoginTime', index: 'lastLoginTime', width:210},
                    {name: 'lastLoginIp', index: 'lastLoginIp', search: false},
                    {
                        name: 'status',
                        index: 'status',
                        width: 120, formatter: status,
                        stype: 'select', searchoptions: {value: {"":"请选择","0": '禁用', "1": '正常'},defaultValue:''}
                    },
                    {
                        name: 'register_from',
                        index: 'register_from',
                        width: 120,
                        stype: 'select', searchoptions: {value: {"":"所有","app": 'app', "weixinmp": '公众号'},defaultValue:''}
                    },
                    {
                        name: 'register_version',
                        index: 'register_version',
                        sorttype: 'integer',
                        searchtype: 'number',
                        searchoptions: {sopt: ['eq']},
                        width: 120,
                        stype: 'select', searchoptions: {value: {"":"所有",
                                "1501":"1501","1502":"1502","1600":"1600","1601":"1601","1602":"1602","1603":"1603"
                            },defaultValue:''}
                    },
                    {
                        name: 'register_channel',
                        index: 'register_channel',
                        width: 120,
                        stype: 'select', searchoptions: {value: {"":"所有",
                                <c:forEach items="${channels}" var="chn" varStatus="sta">
                                "${chn.code}": '${chn.name}'
                                <c:if test="${sta.index != fn:length(channels) -1 }">,</c:if>
                                </c:forEach>
                            },defaultValue:''}
                    }
                ],

                viewrecords: true,
                rowNum: 15,
                rowList: [15, 30, 50],
                pager: pager_selector,
                altRows: true,
                //toppager: true,

                multiselect: true,
                //multikey: "ctrlKey",
                multiboxonly: true,

                loadComplete: function () {
                    var table = this;
                    setTimeout(function () {
                        styleCheckbox(table);

                        updateActionIcons(table);
                        updatePagerIcons(table);
                        enableTooltips(table);
                    }, 0);
                },

                editurl: $path_base + "/dummy.html",//nothing is saved
                caption: "用户列表（可选择操作）",


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

            function gender(cellvalue, options, cell) {
                switch (cellvalue) {
                    case '2':
                        return "女士";
                    case '1':
                        return "男士";
                    default:
                        return '保密';
                }
            }

            function status(cellvalue, options, cell) {
                switch (cellvalue) {
                    case '1':
                        return "正常";
                    case '0':
                        return "封禁";
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
                var url = '/news/user/listdata?' + $("#query_form").serialize();
                $(grid_selector).jqGrid('setGridParam', {

                    url: url

                }).trigger("reloadGrid");
            })
        });
    </script>
</myjs>
</body>
</html>