<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="euc-kr" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="goods" value="${goodsMap.goods}" />
<c:set var="imageFileList" value="${goodsMap.imageFileList}" />


<head>



<!-- ��Ʈ��Ʈ�� 4.3.1 ����   -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
        integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        
 <style>
 		   #addFileButton {
      text-align: center;
   }
 
		  .fixed_join {
		    background-color: #eee;
		}
    	.custom-select {
		    width: 200px; /* �ʿ��� ���� ���̷� �����ϼ��� */
		    text-align : center;
		}
    	.input-form {
		  /*  max-width: 1050px; */
		   margin-top: 80px;
		   padding: 32px;
		   background: #fff;
		   -webkit-border-radius: 10px;
		   -moz-border-radius: 10px;
		   border-radius: 10px;
		   -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		   -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
		   box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
		}
        a {
            color: grey; /* �Ǵ� ���ϴ� �������� ���� */
        }

        .h2 {
            font-size: 24px; /* Increase the font size to your desired value */
            font-weight: bold; /* ���� ����� */
        }

        
       
    </style>

 	  <style>
	.btn-primary:hover {
    background-color: #1b7340; /* �� �κ��� ����ΰų� �ٸ� �������� �����ϼ��� */
    color: #ffffff; /* �� �κ��� ����ΰų� �ٸ� �������� �����ϼ��� */
    border-color: #1b7340; /* �� �κ��� ����ΰų� �ٸ� �������� �����ϼ��� */
}
       .btn-primary {
    background-color: #1b7340;
    border: 2px solid #1b7340;
    color: #ffffff;
    padding: 10px 20px;
    text-decoration: none;
    display: inline-block;
    text-align: center;
	}
		
		.centered {
   		 text-align: center;
			}
		
        .btn-primary.custom-btn {
            color: #1b7340; /* �ؽ�Ʈ ���� ������� ���� */
            background-color: #fff; /* ��� ���� ������� ���� */
            border: 1px solid #1b7340 !important; /* �׵θ� ���� #1b7340���� ���� */
        }

       

        /* ���̺� �� �� �߾����� */
        .center-align {
            text-align: center;
        }
        
        td {
		   
		     white-space: nowrap;
		}
		 tr h2 {
        font-size: 15px; /* ���÷� 24px�� ����. ���ϴ� ũ��� �����ϼ���. */
    }
    </style>






<c:choose>
   <c:when test='${not empty goods.goods_status}'>
      <script>
         window.onload = function() {
            init();
         }

         function init() {
            var frm_mod_goods = document.frm_mod_goods;
            var h_goods_status = frm_mod_goods.h_goods_status;
            var goods_status = h_goods_status.value;
            var select_goods_status = frm_mod_goods.goods_status;
            select_goods_status.value = goods_status;
         }
      </script>
   </c:when>
</c:choose>
<script type="text/javascript">
   function fn_modify_goods(goods_id, attribute) {
      var frm_mod_goods = document.frm_mod_goods;
      var value = "";
      if (attribute == 'goods_sort') {
         value = frm_mod_goods.goods_sort.value;
      } else if (attribute == 'goods_title') {
         value = frm_mod_goods.goods_title.value;
      } else if (attribute == 'goods_price') {
         value = frm_mod_goods.goods_price.value;
      } else if (attribute == 'goods_sales_price') {
         value = frm_mod_goods.goods_sales_price.value;
      } else if (attribute == 'goods_page_total') {
         value = frm_mod_goods.goods_page_total.value;
      } else if (attribute == 'goods_delivery_price') {
         value = frm_mod_goods.goods_delivery_price.value;
      } else if (attribute == 'goods_delivery_date') {
         value = frm_mod_goods.goods_delivery_date.value;
      } else if (attribute == 'goods_status') {
         value = frm_mod_goods.goods_status.value;
      } else if (attribute == 'goods_intro') {
         value = frm_mod_goods.goods_intro.value;
      } else if (attribute == 'publisher_comment') {
         value = frm_mod_goods.publisher_comment.value;
      } else if (attribute == 'recommendation') {
         value = frm_mod_goods.recommendation.value;
      }

      $.ajax({
         type : "post",
         async : false, //false�� ��� ��������� ó���Ѵ�.
         url : "${contextPath}/admin/goods/modifyGoodsInfo.do",
         data : {
            goods_id : goods_id,
            attribute : attribute,
            value : value
         },
         success : function(data, textStatus) {
            if (data.trim() == 'mod_success') {
               alert("��ǰ ������ �����߽��ϴ�.");
            } else if (data.trim() == 'failed') {
               alert("�ٽ� �õ��� �ּ���.");
            }

         },
         error : function(data, textStatus) {
            alert("������ �߻��߽��ϴ�." + data);
         },
         complete : function(data, textStatus) {
            //alert("�۾����Ϸ� �߽��ϴ�");

         }
      }); //end ajax   
   }

   function readURL(input, preview) {
      //  alert(preview);
      if (input.files && input.files[0]) {
         var reader = new FileReader();
         reader.onload = function(e) {
            $('#' + preview).attr('src', e.target.result);
         }
         reader.readAsDataURL(input.files[0]);
      }
   }

   var cnt = 1;
   function fn_addFile() {
      $("#d_file").append(
            "<br>" + "<input  type='file' name='detail_image" + cnt
                  + "' id='detail_image" + cnt
                  + "'  onchange=readURL(this,'previewImage" + cnt
                  + "') />");
      $("#d_file").append(
            "<img  id='previewImage"+cnt+"'   width=200 height=200  style='margin-right: 60px;'/>" );
     
     /*  $("#d_file").append("<td></td>"); */
      $("#d_file")
            .append(
                  "<input  type='button' class='btn btn-secondary' value='�߰�'  onClick=addNewImageFile('detail_image"
                        + cnt
                        + "','${imageFileList[0].goods_id}','detail_image')  />");
      cnt++;
   }

   function modifyImageFile(fileId, goods_id, image_id, fileType) {
      // alert(fileId);
      var form = $('#FILE_FORM')[0];
      var formData = new FormData(form);
      formData.append("fileName", $('#' + fileId)[0].files[0]);
      formData.append("goods_id", goods_id);
      formData.append("image_id", image_id);
      formData.append("fileType", fileType);

      $.ajax({
         url : '${contextPath}/admin/goods/modifyGoodsImageInfo.do',
         processData : false,
         contentType : false,
         data : formData,
         type : 'POST',
         success : function(result) {
            alert("�̹����� �����߽��ϴ�!");
         }
      });
   }

   function addNewImageFile(fileId, goods_id, fileType) {
      //  alert(fileId);
      var form = $('#FILE_FORM')[0];
      var formData = new FormData(form);
      formData.append("uploadFile", $('#' + fileId)[0].files[0]);
      formData.append("goods_id", goods_id);
      formData.append("fileType", fileType);

      $.ajax({
         url : '${contextPath}/admin/goods/addNewGoodsImage.do',
         processData : false,
         contentType : false,
         data : formData,
         type : 'post',
         success : function(result) {
            alert("�̹����� �����߽��ϴ�!");
         }
      });
   }

   function deleteImageFile(goods_id, image_id, imageFileName, trId) {
      var tr = document.getElementById(trId);

      $.ajax({
         type : "post",
         async : true, //false�� ��� ��������� ó���Ѵ�.
         url : "${contextPath}/admin/goods/removeGoodsImage.do",
         data : {
            goods_id : goods_id,
            image_id : image_id,
            imageFileName : imageFileName
         },
         success : function(data, textStatus) {
            alert("�̹����� �����߽��ϴ�!!");
            tr.style.display = 'none';
         },
         error : function(data, textStatus) {
            alert("������ �߻��߽��ϴ�." + textStatus);
         },
         complete : function(data, textStatus) {
            //alert("�۾����Ϸ� �߽��ϴ�");

         }
      }); //end ajax   
   }
</script>

</HEAD>
<BODY>
   <form name="frm_mod_goods" method=post>
      <DIV class="clear"></DIV>
      <!-- ���� ��� ���� �� -->
      <DIV id="container">
         <UL class="tabs">
            <li><A href="#tab1">��ǰ����</A></li>
        <!--     <li><A href="#tab2">��ǰ����</A></li>
            <li><A href="#tab3">��ǰ���ڼҰ�</A></li>
            <li><A href="#tab4">��ǰ�Ұ�</A></li>
            <li><A href="#tab5">���ǻ� ��ǰ ��</A></li>
            <li><A href="#tab6">��õ��</A></li> -->
            <li><A href="#tab7">��ǰ�̹���</A></li>
         </UL>
         <DIV class="tab_container">
            <DIV class="tab_content" id="tab1">
            
            
               <table  class="table">
                  <tr>
                     <td class="fixed_join" width=200>��ǰ�з�</td>
                     <td width=500><select name="goods_sort">
                           <c:choose>
                              <c:when test="${goods.goods_sort=='����ǰ���ǰ' }">
                                 <option value="����ǰ���ǰ" selected>����ǰ���ǰ</option>
                                 <option value="������ �Ϲݰǰ���ǰ">�Ϲݰǰ���ǰ ���</option>
                                 <option value="�ѹ���/Ŀ��" selected>�ѹ���/Ŀ��</option>
                                 <option value="�ǰ�������ǰ">�ǰ�������ǰ</option>
                              </c:when>
                              <c:when test="${goods.goods_sort=='�Ϲݰǰ���ǰ' }">
                                  <option value="����ǰ���ǰ" selected>����ǰ���ǰ</option>
                                 <option value="������ �Ϲݰǰ���ǰ">�Ϲݰǰ���ǰ ���</option>
                                 <option value="�ѹ���/Ŀ��" selected>�ѹ���/Ŀ��</option>
                                 <option value="�ǰ�������ǰ">�ǰ�������ǰ</option>
                              </c:when>
                               <c:when test="${goods.goods_sort=='�ѹ���/Ŀ��' }">
                                  <option value="����ǰ���ǰ" selected>����ǰ���ǰ</option>
                                 <option value="������ �Ϲݰǰ���ǰ">�Ϲݰǰ���ǰ ���</option>
                                 <option value="�ѹ���/Ŀ��" selected>�ѹ���/Ŀ��</option>
                                 <option value="�ǰ�������ǰ">�ǰ�������ǰ</option>
                              </c:when>
                               <c:when test="${goods.goods_sort=='�ǰ�������ǰ' }">
                                  <option value="����ǰ���ǰ" selected>����ǰ���ǰ</option>
                                 <option value="������ �Ϲݰǰ���ǰ">�Ϲݰǰ���ǰ ���</option>
                                 <option value="�ѹ���/Ŀ��" selected>�ѹ���/Ŀ��</option>
                                 <option value="�ǰ�������ǰ">�ǰ�������ǰ</option>
                                  </c:when>
                           </c:choose>
                     </select></td>
                     <td><input type="button" class="btn btn-secondary"  value="�����ݿ�"
                        onClick="fn_modify_goods('${goods.goods_id }','goods_sort')" />
                     </td>
                  </tr>
                  <tr>
                     <td class="fixed_join" >��ǰ�̸�</td>
                     <td><input name="goods_title" type="text" size="40"
                        value="${goods.goods_title }" /></td>
                     <td><input type="button" class="btn btn-secondary" value="�����ݿ�"
                        onClick="fn_modify_goods('${goods.goods_id }','goods_title')" />
                     </td>
                  </tr>

                  <tr>
                     <td class="fixed_join" >��ǰ����</td>
                     <td><input name="goods_price" type="text" size="40"
                        value="${goods.goods_price }" /></td>
                     <td><input type="button" class="btn btn-secondary" value="�����ݿ�"
                        onClick="fn_modify_goods('${goods.goods_id }','goods_price')" />
                     </td>

                  </tr>

                  <tr>
                     <td class="fixed_join" >��ǰ�ǸŰ���</td>
                     <td><input name="goods_sales_price" type="text" size="40"
                        value="${goods.goods_sales_price }" /></td>
                     <td><input type="button" class="btn btn-secondary" value="�����ݿ�"
                        onClick="fn_modify_goods('${goods.goods_id }','goods_sales_price')" />
                     </td>

                  </tr>


                  <%-- <tr>
                     <td>��ǰ ���� ����Ʈ</td>
                     <td><input name="goods_point" type="text" size="40"
                        value="${goods.goods_point }" /></td>
                     <td><input type="button" value="�����ݿ�"
                        onClick="fn_modify_goods('${goods.goods_id }','goods_point')" />
                     </td>

                  </tr> --%>


                  <tr>
                     <td class="fixed_join">��ǰ ��ۺ�</td>
                     <td><input name="goods_delivery_price" type="text" size="40"
                        value="${goods.goods_delivery_price }" /></td>
                     <td><input type="button" class="btn btn-secondary" value="�����ݿ�"
                        onClick="fn_modify_goods('${goods.goods_id }','goods_delivery_price')" />
                     </td>

                  </tr>
                <%--   <tr>
                     <td>��ǰ ���� ������</td>
                     <td><input name="goods_delivery_date" type="date"
                        value="${goods.goods_delivery_date }" /></td>
                     <td><input type="button" value="�����ݿ�"
                        onClick="fn_modify_goods('${goods.goods_id }','goods_delivery_date')" />
                     </td>

                  </tr> --%>

                  <tr>
                     <td class="fixed_join">��ǰ����</td>
                     <td><select name="goods_status">
                       
                           <option value="���λ�ǰ">���λ�ǰ</option>
                           <option value="�α��ǰ" selected>�α��ǰ</option>
                           <option value="�Ϲݻ�ǰ">�Ϲݻ�ǰ</option>
                     </select> <input type="hidden" name="h_goods_status"
                        value="${goods.goods_status }" /></td>
                     <td><input type="button" class="btn btn-secondary" value="�����ݿ�"
                        onClick="fn_modify_goods('${goods.goods_id }','goods_status')" />
                     </td>
                  </tr>
                  <tr>
                     <td colspan=3><br></td>
                  </tr>
               </table>
            </DIV>
     <%--        <DIV class="tab_content" id="tab2">
               <h4>å����</h4>
               <table>
               </table>
            </DIV>
            <DIV class="tab_content" id="tab4">
               <H4>��ǰ�Ұ�</H4>
               <P>
               <table>
                  <tr>
                     <td>��ǰ�Ұ�</td>
                     <td><textarea rows="100" cols="80" name="goods_intro">
                  ${goods.goods_intro }
                  </textarea></td>
                     <td>&nbsp;&nbsp;&nbsp;&nbsp; <input type="button" class="btn btn-secondary"
                        value="�����ݿ�"
                        onClick="fn_modify_goods('${goods.goods_id }','goods_intro')" />
                     </td>
                  </tr>
               </table>
               </P>
            </DIV>
            <DIV class="tab_content" id="tab5"></DIV>
            <DIV class="tab_content" id="tab6">
               <table>
               </table>
            </DIV> --%>
            <DIV class="tab_content" id="tab7">
               <form id="FILE_FORM" method="post" enctype="multipart/form-data"  >
				<h4>��ǰ�̹���</h4>
				 <table  class="table">
					 <tr>
					<c:forEach var="item" items="${imageFileList }"  varStatus="itemNum">
			        <c:choose>
			            <c:when test="${item.fileType=='main_image' }">
			              <tr>
						    <td class="fixed_join">���� �̹���</td>
						    <td>
							  <input type="file"  id="main_image"  name="main_image"  onchange="readURL(this,'preview${itemNum.count}');" />
						      <%-- <input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  /> --%>
							  <input type="hidden"  name="image_id" value="${item.image_id}"  />
							<br>
						</td>
						<td>
						  <img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}" />
						</td>
						<td>
						  &nbsp;&nbsp;&nbsp;&nbsp;
						</td>
						 <td>
						 <input  type="button"  class="btn btn-secondary" value="����"  onClick="modifyImageFile('main_image','${item.goods_id}','${item.image_id}','${item.fileType}')"/>
						</td> 
					</tr>
					
			         </c:when>
			         <c:otherwise>
			           <tr  id="${itemNum.count-1}">
						<td class="fixed_join">�� �̹���${itemNum.count-1 }</td>
						<td>
							<input type="file" name="detail_image"  id="detail_image"   onchange="readURL(this,'preview${itemNum.count}');" />
							<%-- <input type="text" id="image_id${itemNum.count }"  value="${item.fileName }" disabled  /> --%>
							<input type="hidden"  name="image_id" value="${item.image_id }"  />
							<br>
						</td>
						<td>
						  <img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}">
						</td>
						<td>
						  &nbsp;&nbsp;&nbsp;&nbsp;
						</td>
						 <td>
						 <input  type="button"   class="btn btn-secondary" value="����"  onClick="modifyImageFile('detail_image','${item.goods_id}','${item.image_id}','${item.fileType}')"/>
						  <input  type="button"   class="btn btn-secondary" value="����"  onClick="deleteImageFile('${item.goods_id}','${item.image_id}','${item.fileName}','${itemNum.count-1}')"/>
						</td> 
					</tr>
					
			         </c:otherwise>
			       </c:choose>		
			    </c:forEach>
			    <tr >
			    	<td class="fixed_join">
			    	</td>
			    	
			      <td colspan="4">
				      <div id="d_file">
						  <%-- <img  id="preview${itemNum.count }"   width=200 height=200 src="${contextPath}/download.do?goods_id=${item.goods_id}&fileName=${item.fileName}" /> --%>
				      </div>
			       </td>
			       
			       
			    </tr>
		   <tr>
		     <td align=center colspan=5>
		     
		     <input  id="addFileButton"  type="button"  class="btn btn-secondary" value="�̹��������߰��ϱ�"  onClick="fn_addFile()"  />
		   </td>
		</tr> 
	</table>
	</form>
	</DIV>
	<DIV class="clear"></DIV>
					
</form>	