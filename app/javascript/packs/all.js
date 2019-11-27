window.onload = function(){
  var brandSelect = document.getElementById("brand_select-JS");
  var modelSelect = document.getElementById("model_select-JS");
  var partSelect = document.getElementById("part_select-JS");
  var mainCommit = document.getElementById("main_commit-JS");
  var mainForm = document.getElementById("main_form-JS");
  var brand_text_hidden = document.getElementById("order_text_for_brand_full-JS");
  var model_text_hidden = document.getElementById("order_text_for_model_full-JS");
  var parts_text_hidden = document.getElementById("order_text_for_parts_full-JS");

  brandSelect.onchange = function() {
    brandSelect.classList.remove('border-danger');
    brand_text_hidden.value = brandSelect.value;
  }

  modelSelect.onchange = function() {
    modelSelect.classList.remove('border-danger');
    model_text_hidden.value = modelSelect.value;
  }

  partSelect.onchange = function() {
    partSelect.classList.remove('border-danger');
    parts_text_hidden.value = partSelect.value;
  }

  mainCommit.onclick = function() {
    if (brandSelect.value == '' || modelSelect.value == '' || partSelect.value == '') {
      if (brandSelect.value == '') {
        brandSelect.classList.add('border-danger');
      }
      if (modelSelect.value == '') {
        modelSelect.classList.add('border-danger');
      }
      if (partSelect.value == '') {
        partSelect.classList.add('border-danger');
      }
    } else {
      mainForm.submit();
    }
  }
};