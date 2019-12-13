<%--
  Created by IntelliJ IDEA.
  User: 浩瀚
  Date: 2019/12/9
  Time: 18:22
  To change this template use File | Settings | File Templates.
--%>
<!--
    这里是具体的哪一个版面
-->
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>所有版块显示</title>
    <meta charset="UTF-8">
    <%
        //这个的路径是以斜线开始的，不以斜线结束
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <!--引入jquery-->
    <script src="${APP_PATH}/statics/js/jquery-1.10.2.js"></script>
    <!--引入样式-->
    <link href="${APP_PATH}/statics/css/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <link href="${APP_PATH}/statics/css/main.css" rel="stylesheet">
    <script src="${APP_PATH}/statics/css/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/statics/js/ckeditor/ckeditor.js"></script>
</head>
<body>
    <div class="containers">
            <!--上方的导航栏-->
            <div class="top-navigate">
                <div class="container">
                    <div class="row">
                        <div class="col-md-12">
                            <div><h5>BBS论坛</h5></div>
                        </div>
                    </div>
                </div>
            </div>
            <!--左部的个人信息栏-->
            <div class="left-info">
                <div class="container" style="width:100%">
                    <div class="row">
                        <h4>欢迎使用此bbs论坛</h4>
                    </div>
                    <div class="row">
                        <!--登录界面-->
                        <div class="col-md-12">
                            <button class="btn btn-primary" id="emp_add_modal_btn">登录</button>
                            <button class="btn btn-danger" id="emp_delete_all">注册</button>
                        </div>
                        <div class="col-md-12">
                            <div class="info">
                                <ul class="nav nav-pills nav-stacked">
                                    <li role="presentation"><a href="#">个人主页</a></li>
                                    <li role="presentation"><a href="${APP_PATH}/main/notPerfect?sectionId=${section.sId}">加精</a></li>
                                    <li role="presentation"><a href="${APP_PATH}/main/notTop?sectionId=${section.sId}">置顶</a></li>
                                    <li role="presentation"><a href="${APP_PATH}/index1.jsp">返回主页</a></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--右部的主页内容栏-->
            <div class="right-main">
                <div class="container">
                    <!--导航区-->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="nav">
                                <div class="titleShow"><h1>${section.sSectionname}版面的所有主贴</h1></div>
                                <!--显示选择看帖子还是精华帖-->
                                <div class="selects">
                                    <div class="row">
                                        <ul class="nav nav-tabs">
                                            <li role="presentation" class="active"><a href="${APP_PATH}/section/thesection?sectionId=${section.sId}">帖子</a></li>
                                            <li role="presentation"><a href="${APP_PATH}/section/perfects?sectionId=${section.sId}">精华帖</a></li>
                                            <li role="presentation"><a href="#">其他</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--内容区-->
                    <div class="row">
                        <div class="col-md-10">
                            <!--展示帖子或者精华帖-->
                            <div class="allMains">
                                <div class="row">
                                    <div class="col-md-12"><!--存放所有的帖子-->
                                        <table class="table table-hover" id="mains_table">
                                            <thead>
                                                <tr>
                                                    <th>序号</th>
                                                    <th>标题</th>
<%--                                                    <th>内容</th>--%>
                                                    <th>发帖人</th>
                                                    <th>发帖时间</th>
                                                </tr>
                                            </thead>

                                            <tbody>
<%--                                                <c:forEach items="${mainlist}" var="mainPost">--%>
<%--                                                    <tr>--%>
<%--                                                        <c:if test="${mainPost.mIsontop==1}">--%>
<%--                                                            <td>置顶</td>--%>
<%--                                                        </c:if>--%>
<%--                                                        <c:if test="${mainPost.mIsontop==0}">--%>
<%--                                                            <td>${mainPost.mMainid}</td>--%>
<%--                                                        </c:if>--%>
<%--                                                        <td>${mainPost.mTitle}</td>--%>
<%--&lt;%&ndash;                                                        <td>${mainPost.mContent}</td>&ndash;%&gt;--%>
<%--                                                        <td>${mainPost.user.uNickname}</td>--%>
<%--                                                        <td>${mainPost.mMaindate}</td>--%>
<%--                                                    </tr>--%>
<%--                                                </c:forEach>--%>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--展示发帖按钮-->
<%--                        <div class="col-md-2">--%>
<%--                            <div>--%>
<%--                                <a href="#edit-publish">发帖</a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                    </div>

                    <!--显示分页信息-->
                    <div class="row">
                        <!--分页文字信息-->
                        <div class="col-md-6" id="page_info_area">

                        </div>
                        <!--分页条-->
                        <div class="col-md-6" id="page_nav_area">

                        </div>
                    </div>

                    <!--编辑区-->
                    <div class="row">
                        <!--此区域进行发帖操作-->
                        <a name="edit-publish"></a>
                        <div class="edit-publish" >
                            <div class="container">
                                <div class="row">
                                    <p>发帖编辑区</p>
                                </div>
                                <div class="row">
                                    <div class="title">
                                        <input type="text" name="title" id="P-title" style="width:800px;height:50px" placeholder="请填写标题"/>
                                    </div>
                                </div>
                                <div class="row">
<%--                                    <div class="navi">--%>
<%--                                        <div class="row">--%>
<%--                                            <!--提交图片-->--%>
<%--                                            <input type="file" name="pic" id="pic" value="" accept="image/*" style="display:none">--%>
<%--                                            <div class="col-sm-4"><a href="#" class="import">图片</a></div>--%>
<%--                                            <div class="col-sm-4">表情</div>--%>
<%--                                            <div class="col-sm-4">视频</div>--%>
<%--                                        </div>--%>
<%--                                    </div>--%>
                                    <textarea name="content" id="content" placeholder="请输入信息"/>
                                    </textarea>
<%--                                    <div class="content" contenteditable="true" id="content">--%>

<%--                                    </div>--%>
                                </div>
                                <div class="row">
                                    请选择是否发布积分奖励：否<input type="radio" name="points" value="0" id="nopoint" checked> 是<input type="radio" name="points" id="haspoint">
                                    <p style="display:inline" class="notshowpoint"><span>请输入需要奖励的积分数
                                    </span><input type="text" id="point" oninput="value=value.replace(/[^\d]/g,'')"></p>
                                </div>
                                <div class="row">
                                    <div class="sub">
                                        <button class="btn btn-primary" id="publish_btn">发帖</button>
                                    </div>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
    </div>
<script>
    //1.页面加载完成后，直接发送一个ajax请求，拿到分页信息
    $(function(){
        CKEDITOR.replace( 'content',{
            height:100,
            width:900
        });
        $(".notshowpoint").hide();
        to_page(1);//首次加载页面时显示第一页
    });
    //跳转到页面
    function to_page(pn){
        var data={
            "pn":pn,
            "sectionId":${section.sId}
        };
        $.ajax({
            url:"${APP_PATH}/main/findMainsInSection",
            data:data,
            type:"get",
            success:function (result) {
                //console.log(result);
                //1.解析并且显示员工数据
                build_mains_table(result);
                //2.解析并且显示分页信息
                build_page_info(result);
                //3.分页条的显示
                build_page_nav(result);
            }
        });
    }
    function getContentData(){
        var content=CKEDITOR.instances.content.getData();//获取texarea的内容
        return content;
    }
    //table结构
    function build_mains_table(result) {
        //清空table表
        $("table tbody").empty();
        var emps=result.extend.pageInfo.list;
        var topmains=result.extend.toplist;//置顶的几个帖子

        //这里是置顶帖
        $.each(topmains,function (index,item) {

            var mainIdTd=$("<td></td>").append("<span class=\"label label-danger\">置顶</span>").addClass("topmain")//增加一个class，标识为置顶帖;
            var cancelTopUl=$("<li></li>").append("<a href='#'>取消置顶</a>").addClass("notshow");
            var mainTitleTd=$("<td></td>").append(item.mTitle);
            var userNickname=$("<td></td>").append(item.user.uNickname);
            var mainDate=$("<td></td>").append(item.mMaindate);
            //指向特定帖子的链接
            var link=$("<a href='${APP_PATH}/main/theMain?mainId="+item.mMainid+"' target='_blank' class='link'></a>");
            mainTitleTd.append(link);
            $("<tr></tr>")
                .append(mainIdTd)
                .append(mainTitleTd)
                .append(userNickname)
                .append(mainDate)
                .attr("mainId",item.mMainid)//增加一个帖子编号属性
                .appendTo("#mains_table tbody");
            //新增一个下拉菜单
            $("<ul></ul>")
                .append(cancelTopUl).attr("mainId",item.mMainid).appendTo(mainIdTd);
        });
        //这里是除了置顶帖之外的帖子
        $.each(emps,function (index,item) {
            // var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>" );
            var link=$("<a href='#' class='link'></a>");
            var mainIdTd=$("<td></td>").append(item.mMainid).addClass("normalmain");//增加一个class，标识为非置顶帖;
            var mainTitleTd=$("<td></td>").append(item.mTitle);
            var userNickname=$("<td></td>").append(item.user.uNickname);
            var mainDate=$("<td></td>").append(item.mMaindate);

            var link=$("<a href='${APP_PATH}/main/theMain?mainId="+item.mMainid+"' target='_blank' class='link'></a>");
            mainTitleTd.append(link);
            //append方法执行完返回的还是原来的元素
            $("<tr></tr>")
                .append(mainIdTd)
                .append(mainTitleTd)
                .append(userNickname)
                .append(mainDate)

                .attr("mainId",item.mMainid)//增加一个帖子编号属性
                .appendTo("#mains_table tbody");
        });
    }
    //解析显示分页信息
    function build_page_info(result){
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页，" +
            "总共"+result.extend.pageInfo.pages+"页，" +
            "总共"+result.extend.pageInfo.total+"条记录");
        totalRecord=result.extend.pageInfo.total;
        currentPage=result.extend.pageInfo.pageNum;
    }
    //解析显示分页条，点击分页要去下一页
    function build_page_nav(result){
        $("#page_nav_area").empty();
        var ul=$("<ul><ul>").addClass("pagination");
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            //为元素添加翻页事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum-1);
            });
        }
        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.extend.pageInfo.hasNextPage==false){
            lastPageLi.addClass("disabled");
            nextPageLi.addClass("disabled");
        }else{
            //为元素添加翻页事件
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);
            });
        }
        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        //遍历给ul中添加页码
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item) {
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum==item){
                numLi.addClass("active");//高亮显示
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加末页和下一页的提示
        ul.append(nextPageLi).append(lastPageLi);
        //把ul添加到nav中
        var navEle=$("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    /*
        点击发送图片，触发表单的点击事件
     */
    $('.import').click(function(){
        $("#pic").trigger('click');
    });
    // 当表单文件有变化时执行提交动作
    $('[name="pic"]').change(function(){
        if($(this).val()){
            $('.import').addClass('disabled');//图片链接禁用
            //$(this).parent().submit();
            var formData = new FormData();
            formData.append("picture", $("#pic")[0].files[0]);
            //alert("file");
            $.ajax({
                url:"${APP_PATH}/upload/picture",
                type:"POST",
                data:formData,
                contentType:false,
                processData:false,//这个很有必要，不然不行
                dataType:"json",
                mimeType:"multipart/form-data",
                success:function (result) {
                    if(result.code===100){
                        var contents=$("#content").html();
                        // var paths="/bbs/statics/images/"+result.extend.filename;
                        var paths="${APP_PATH}/statics/images/"+result.extend.filename;
                        contents+="<div><img src=\""+paths+"\" width=200 height=200><div>";
                        $(".content").html(contents);
                    }else{
                        alert("failed");
                    }
                }
            });
        }
    });
    /*
        提交主贴的内容
     */
    $("#publish_btn").click(function () {
        var content=getContentData();
        var point=$("#point").val();
        if(!$("#point").val())
            point=0;
        else point=parseInt(point);
        var data={
            "mMainerid":4,//${sessionScope.userId}设置一个默认的发帖人
            "mSectionid":${section.sId},
            "mTitle":$("#P-title").val(),
            // "mContent":$("#content").html(),
            "mContent":content,
            "mPoint":point
        };
        //alert(data);
        $.ajax({
            url:"${APP_PATH}/main/publish",
            type:"post",
            data:data,//一个json封装的数据
            //dataType: "json",//返回的数据格式为json
            success:function (result) {
                if(result.code==100){
                    //$(".showContent").html(result.extend.content);
                    // $("#content").empty();
                    CKEDITOR.instances.content.setData("");
                    $("#P-title").val("");
                    $("#point").val("");//输入框置空
                    $(".notshowpoint").hide();
                    to_page(1);//跳转到第一页数据处
                }
            }
        });
    });

    //1.点击编辑钮创建之前就绑定了事件，编辑信息资料
    //2.可以在创建按钮的时候绑定事件
    //3.绑定点击.live()
    //jquery新版本没有live(),使用on替代
    $(document).on("mouseover ",".topmain",function () {//mouseover
        $(this).find('li').show();
    });
    $(document).on("mouseout ",".topmain",function () {//mouseover
        $(this).find('li').hide();
    });

    //点击取消置顶
    $(document).on("click ",".notshow",function () {//mouseover
        var mainId=$(this).parent('ul').attr("mainId");
        if(confirm("确认取消"+mainId+"的置顶吗？")){
            $.ajax({
                url:"${APP_PATH}/main/cancelTop",
                data:"mainId="+mainId,
                success:function (result) {
                    $(this).find('li').hide();
                    if(result.code==100){
                        to_page(1);
                    }
                }
            });
        }
    });
    //对于奖励的积分设置
    $("#haspoint").click(function () {
        $(".notshowpoint").show();
    });
    $("#nopoint").click(function () {
        $("#point").val("");//输入框置空
        $(".notshowpoint").hide();
    });
    //奖励积分输入框的变化
    $("#point").change(function () {
       var point=$(this).val();
       //alert(point);
    });

    //点击某个帖子
    <%--$(document).on("click ",".link",function () {--%>
    <%--    //alert($(this).attr('href'));--%>
    <%--    var mainId=$(this).attr('href');--%>
    <%--    window.open("${APP_PATH}/main/theMain?mainId="+mainId,"_self");--%>
    <%--})--%>
</script>
</body>
</html>
