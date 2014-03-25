'use strict';
tinyMCE.init({ 
  selector:'#post_content',
  theme: "modern",
  plugins: [
    "advlist autolink lists link image charmap print preview hr anchor pagebreak",
    "searchreplace wordcount visualblocks visualchars code fullscreen",
    "insertdatetime media nonbreaking save table contextmenu directionality",
    "emoticons template paste textcolor"
  ],
  menubar: false,
  statusbar: false,
  height: 300,
  toolbar1: "preview | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | forecolor backcolor emoticons | searchreplace code",
  image_advtab: true,
});
