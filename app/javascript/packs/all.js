window.onload = function(){
  var brandSelect = document.getElementById("brand_select-JS");
  var modelSelect = document.getElementById("model_select-JS");
  var partSelect = document.getElementById("part_select-JS");
  var mainCommit = document.getElementById("main_commit-JS");
  var mainForm = document.getElementById("main_form-JS");
  var partsDiv = document.getElementById("parts_div-JS");
  var addPartsBtn = document.getElementById("add_btn-JS");
  var brand_text_hidden = document.getElementById("order_text_for_brand_full-JS");
  var model_text_hidden = document.getElementById("order_text_for_model_full-JS");
  var parts_text_hidden = document.getElementById("order_text_for_parts_full-JS");
  var parts_names_text_hidden = document.getElementById("order_text_for_parts_names_full-JS");

  brandSelect.onchange = function() {
    brandSelect.classList.remove('border-danger');
    brand_text_hidden.value = brandSelect.options[brandSelect.selectedIndex].text;

    $.ajax({
      type: "GET",
      url: "/main/get_models",
      dataType: "script",
      data : {
        brand_id: brandSelect.value
      }
    });
  }

  modelSelect.onchange = function() {
    modelSelect.classList.remove('border-danger');
    console.log(modelSelect.options[modelSelect.selectedIndex].text);
    model_text_hidden.value = modelSelect.options[modelSelect.selectedIndex].text;
  }

  partSelect.onchange = function() {
    partSelect.classList.remove('border-danger');
  }

  addPartsBtn.onclick = function() {
    partsDiv.append(partSelect.options[partSelect.selectedIndex].text);
    partsDiv.appendChild(document.createElement('br'));
    parts_text_hidden.value = parts_text_hidden.value + "," + partSelect.value;
    parts_names_text_hidden.value = parts_names_text_hidden.value + "," + partSelect.options[partSelect.selectedIndex].text;
  }

  mainCommit.onclick = function() {
    console.log("submit work");

    if (brandSelect.value == '' || modelSelect.value == '' || partSelect.value == '') {
      if (brandSelect.value == '') {
        brandSelect.classList.add('border-danger');
      }
      if (modelSelect.value == '') {
        modelSelect.classList.add('border-danger');
      }
      if (parts_text_hidden.value == '') {
        partSelect.classList.add('border-danger');
      }
    } else {
      mainForm.submit();
    }
  }
};