(function (window) {

   let uploadImage=function(options){

       let defaultOption={
          targetId:"divUpload",
          server:"http://localhost:8080",
          imgSrc:"/upload/nopic.jpg",
          hiddenFiledName:"tupian",
          url:"/admin/upload",
          cssClass:"upload-component",
       };

       Object.assign(defaultOption,options);
       let target=$("#"+defaultOption.targetId);
       if(defaultOption.imgSrc==""){
           defaultOption.imgSrc="/upload/nopic.jpg";
       }
       $(`[name=${defaultOption.hiddenFiledName}]`).val(defaultOption.imgSrc);
       let imgFieldName="img"+defaultOption.targetId;
       let fileFieldName="file"+defaultOption.targetId;
       target.append(`  <div  class="${defaultOption.cssClass}">
            \t\t\t   <img name="${imgFieldName}" class="image" src="${defaultOption.server}${defaultOption.imgSrc}" alt=""/>
            \t\t\t   <div class="upload">
            \t\t\t\t   <div class="plus-circle"></div>
            \t\t\t\t   <input name="${fileFieldName}" type="file" accept=".jpg,.jpep,.png,.gif" />
            \t\t\t   </div>
            \t\t   </div> 
       `);
       let uploadComponent=target.find(`.${defaultOption.cssClass}`);
       uploadComponent.each(function () {
           $(this).find(`[name=${fileFieldName}]`).change(function () {
               let formData = new FormData();
               let file=$(this)[0].files[0];
               formData.append('file', file);
               let src=window.URL.createObjectURL(file);
               $.ajax({
                   url:defaultOption.server+defaultOption.url,
                   type:"POST",
                   data:formData,
                   async: false,
                   cache:false,
                   contentType: false,
                   processData: false,
                   dataType:"json",
                   success: function (res) {
                       if(res.stateCode<0)
                           alert(res.des);
                       if(res.data.length>0){
                           $(`[name=${defaultOption.hiddenFiledName}`).val("/upload/temp/"+res.data[0].fileName);
                           $(`[name=${imgFieldName}`).attr("src",res.data[0].url);
                       }
                   }
               });
           });
       });

   } ;

   let tabs= function(options){
       let defaultOption={
           el:".dw-tabs"
       };
       let index=$(`${defaultOption.el}`).find(">.hd .active").index();
       $(`${defaultOption.el}`).find(">.bd .it").eq(index).show().siblings().hide();
       $(`${defaultOption.el} .it`).click(function () {
           let index = $(this).index();
           $(this).addClass("active").siblings().removeClass("active");
           $(`${defaultOption.el}`).find(">.bd .it").eq(index).show().siblings().hide();
       });
   };


   let uploadImages=function(options){
       let defaultOption={
           targetId:"divUpload",
           server:"http://localhost:8080",
           imgSrc:"/upload/nopic.jpg",
           hiddenFiledName:"tupian",
           url:"/admin/upload",
           cssClass:"upload-component",
       };

       Object.assign(defaultOption,options);
       let target=$("#"+defaultOption.targetId);
       if(defaultOption.imgSrc==""){
           defaultOption.imgSrc="/upload/nopic.jpg";
       }
       $(`[name=${defaultOption.hiddenFiledName}]`).val(defaultOption.imgSrc);
       let imgFieldName="img"+defaultOption.targetId;
       let fileFieldName="file"+defaultOption.targetId;
       target.append(`  <div  class="${defaultOption.cssClass}">
            \t\t\t   <div class="upload">
            \t\t\t\t   <div class="plus-circle"></div>
            \t\t\t\t   <input name="${fileFieldName}" type="file" accept=".jpg,.jpep,.png,.gif" />
            \t\t\t   </div>
            \t\t   </div> 
       `);

   }
   window.dapperUtil={
       uploadImage:uploadImage,
       tabs:tabs,
       uploadImages:uploadImages
   };
})(window);