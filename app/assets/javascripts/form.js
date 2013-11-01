window.lpa = window.lpa || {}

// Select the given value of a select box where present
lpa.updateSelectbox = function (el, value) {
  var found = false,
      field = el.attr('name'),
      form = el.closest('form');

  // Check if value is in list
  el.children('option').each(function () {
    if ($(this).prop('value') === value) {
      found = true;
    }
  });

  // If not an available option, change field to text box
  if (!found) {
    el.val('Other...').change();
  }

  // Apply the correct value
  // As the field changes to a text box we loose it's reference,
  // so we need to re-slect the element.
  form.find('[name=' + field + ']').val(value); // use the name attr as it's unique & will always exist
};


$(document).ready(function () {

  // ====================================================================================
  // COMMON VARIABLES

  var body = $('body');

  // ====================================================================================
  // DETAILS TAG SUPPORT

  // $('html').addClass($.fn.details.support ? 'details' : 'no-details');
  // $('details').details();

  // ====================================================================================
  // Register - view docs page

  $('.js-clonewarning').click(function () {
    alert("You've chosen to make an LPA based on a previous LPA.\n\n" +
      "When you come to enter personal details for the donor, attorney and other roles, there'll be a drop-down menu at the top of each form. You can select any name from this menu and their information will be filled in automatically.\n\n" +
      "Please note: If you close the browser window or log out while making the new LPA, you won't be able to use this feature when you return. You can still finish making the new LPA, but the drop-down menus won't appear.")
  });

  // ====================================================================================
  // FORM VALIDATION

  body.on('click', 'form [role="alert"] a', function() {
    var $target = $($(this).attr('href'));
    console.log('click');
    $('html, body')
      .animate({
        scrollTop: $target.offset().top
      }, 300)
      .promise()
      .done(function() {
        $target.closest('.group').find('input,select').first().focus();
      });
  });


  // ====================================================================================
  // TOGGLEABLE FORMS



  // Donor cannot sign LPA
  $(document).delegate('#donor_cannot_sign', 'change', function (evt) {
    var donorCannotSign = $(this).is(':checked');
    if (donorCannotSign) {
      $('#donorsignprompt').show();
    } else {
      $('#donorsignprompt').hide();
    }
  });

  // Cancel pop-up
  body.on('click', 'button#form-cancel', function (e) {
    e.preventDefault();
    $('#lightboxclose').click();
  });


  // RADIOS WITH CONDITIONAL CONTENT
  //
  // A jQuery function for toggling content based on selected radio buttons
  //
  // Usage:
  //
  // $(radio).hasConditionalContent();
  //
  // Where radio is one or more of the radios in the group.
  // The elements to be toggled must have an ID made from a concatenation of 'toggle', the radio name and value.
  // For example, a radio with name="radios" and a value of "1" will toggle an element with id="toggle-radios-1".


  jQuery.fn.hasConditionalContent = function() {
      var name = $(this).attr('name');
      $("[id^='toggle-"+name+"']").hide();

      $('[name="'+name+'"]').change(function(){
          if($(this).is(':checked')){
              $('[id^="toggle-'+name+'"]').hide();
              $('[id="toggle-' + name + '-' + $(this).attr("id") + '"]').show();
          }
      }).change();
  }

  $('[name="certificateProviderStatementType"]').hasConditionalContent();
  $('[name="lpa[how_attorneys_act]"]').hasConditionalContent();
  $('[name="lpa[how_replacement_attorneys_act]"]').hasConditionalContent();


  // Who is applying to register?

  $("[name='whoIsMakingThisApplication']").change(function(){
    if($(this).val() == 'attorneys' ){
        $('.attorney-applicant input:checkbox').prop('checked', true);
    } else {
        $('.attorney-applicant input:checkbox').prop('checked', false);
    }
  })

  $(".attorney-applicant input").change(function(){
    if($(".attorney-applicant input").is(':checked')){
      $("input[name='whoIsMakingThisApplication'][value='attorneys']").prop('checked', true);
    } else {
      $("input[name='whoIsMakingThisApplication'][value='donor']").prop('checked', true);
    }
  });


  // Calendar control for date fields

  // $('.date-field input').datepicker(
  //   {
  //     dateFormat: "dd/mm/yy",
  //     altFormat: "dd/mm/yy",
  //     firstDay: 1,
  //     autoSize:true,
  //     changeMonth:true,
  //     changeYear:true,
  //     beforeShow: function(input, inst) {
  //         inst.dpDiv.css({marginTop: -input.offsetHeight + 'px', marginLeft: input.offsetWidth + 'px'});
  //     }
  //   }
  // );


  // Any previous LPAs?

  $('#previousLpa').change(function(){
    if($('#toggle-previousLpa textarea').val() != ''){
        $('#previousLpa').prop('checked', true);
    }
    if($(this).is(':checked')) {
        $('#toggle-previousLpa').show();
    } else {
        $('#toggle-previousLpa textarea').val('');
        $('#toggle-previousLpa').hide();
    }
  }).change();


  // Any other info?

  $('#otherInfo').change(function(){
    if($('#toggle-otherInfo textarea').val() != ''){
        $('#otherInfo').prop('checked', true);
    }
    if($(this).is(':checked')) {
        $('#toggle-otherInfo').show();
    } else {
        $('#toggle-otherInfo textarea').val('');
        $('#toggle-otherInfo').hide();
    }
  }).change();


  // Fee remissions

  $allRevisedFees = $('.revised-fee').hide();

  $('#claimBenefits, #receiveUniversalCredit, #hasLowIncome').change(function(){
    var $cheque = $('#pay-by-cheque');

    var showChequeOption = function (option) {
      if (option) {
        $cheque.show();
      } else {
        $cheque.hide();
        $cheque.find('#payByCheque').prop('checked', false);
      }
    };

    $allRevisedFees.hide();
    showChequeOption(true);

    if ($('#claimBenefits').is(':checked')) {
      $revisedFee = $('#revised-fee-0').show();
      showChequeOption(false);
    } else if ($('#receiveUniversalCredit').is(':checked')) {
      $revisedFee = $('#revised-fee-uc').show();
      showChequeOption(false);
    } else if ($('#hasLowIncome').is(':checked')) {
      $revisedFee = $('#revised-fee-65').show();
    }
  });


  // Make button text reflect chosen payment option

  $('#claimBenefits, #payByCheque, #receiveUniversalCredit').change(function(){
      if($('#claimBenefits, #payByCheque, #receiveUniversalCredit').is(':checked')) {
          $('#form-submit').val('Proceed');
          $('#contact-email').hide();
      } else {
          $('#form-submit').val('Proceed to payment');
          $('#contact-email').show();
      }
  }).change();



  // ====================================================================================
  // HELP SYSTEM

  $('#help-system').hide();

  $(".open-help-system").click(function(event) {
      var elHelp = $('#help-system');
      var sectionName = $(this).attr('href').replace('#', '');
      elHelp.show();
      var lightBox = OPGPopup.popup(elHelp, "help-system", $(this));

      // Set help page to the one specified in the href of the link
      lightBox.find('li[data-filter="section-help-' + sectionName + '"] a').click();
      //$('.help-system').offset({ top: -32});
      return false;
  });

  // Make inline links to other help pages work
  $('#help-system .help-sections a[href^="#/help/"]').click(function(event){
      var href = $(this).attr('href');
      $('#help-system .help-topics a[href="' + href + '"]').click();
  });


  // ====================================================================================
  // POP-UP PERSON FORM

  $('body').on('click', '.popup-form-link', function (e) {
    e.preventDefault();

    var $source = $(this),
        url = $source.attr('href'),
        form = $source.attr('data-form');

    // If this link is disabled then stop here
    if ($source.hasClass('disabled')) return;

    $source.spinner();

    // Strip the form from the DOM if it already exists
    $('.person-form').remove();

    $.get(url, function (html) {
      $source.spinner('off');

      // Create the lightbox and add content
      var $lightbox = $('<div id="form-lightbox" class="person-form" />').append(html),
          $submit = $('#form-save', $lightbox);

      // Dev only
      if (window.location.hostname.indexOf('.local') != -1) {
        $lightbox.prepend('<a href="#" id="form-populate">Populate with test data</a>');
      }

      var isLoggedIn = false;

      $.ajax({
          url:'/user/is-logged-in',
          dataType: "json",
          async: false,
          timeout: 10000, // in miliseconds
          cache: false,
          success:function(data) {
              isLoggedIn = data.isLoggedIn;
          }
      });

      if (!isLoggedIn) {
        location.reload();
        return;
      }

      // Display as a modal (lightbox)
      OPGPopup.popup($lightbox, "form-popup", $source);

      // Initialise postcode lookup
      $lightbox.opgPostcodeLookup();

      // Initialise details tag within the lightbox
      $('details', $lightbox).details();

      // Convert title text field to select box
      $('#title', $lightbox).convertToTitleSelect();

      // Relationship: other toggle
      $('#relationshipToDonor').change(function () {
        var other = $('#relationshipToDonorOther').closest('.group');
        if ($(this).val() == 'Other') {
          other.show().find('input').focus();
        } else {
          other.hide();
        }
      }).change().closest('form').data('dirty', false);

      // Disable form when showing an empty form
      $submit.attr('disabled', $('#address-addr1', $lightbox).val() == ''); // we can assume that #address-addr1 contains a string when editing details

      // Listen for changes to form
      $('input, select', $lightbox).change(function () {
        var allPopulated = true;
        var allFields = $('label.required + input, label.required ~ select', $lightbox);
        var addressFields = $('input[name^="address"]', $lightbox);

        // Test required fields are populated
        allFields.each(function () {
          if ($.trim($(this).val()) == '') {
            allPopulated = false;
          }
        });

        // Count populated address fields
        var countAddr = addressFields.filter(function () {
          return !($.trim($(this).val()) == '');
        }).length;

        // Test address fields - business logic states 2 address fields as min
        if (countAddr < 2) {
          allPopulated = false;
        }

        $submit.attr('disabled', !allPopulated);
      });

      var donorCannotSign = $('#donor_cannot_sign').is(':checked');
      if (donorCannotSign) {
        $('#donorsignprompt').show();
      } else {
        $('#donorsignprompt').hide();
      }

      // Dev only
      $('a#form-populate').bind('click', function () {
        $.ajax( {
          url:'/service/get/' + form,
          dataType:'json',
          success: function(data) {
            $('.address-hideable').show();
            $('input#address-postcode').parent().show();

            for(var index in data) {
              $('#' + index).val(data[index]);
            }

            $('input#address-addr1').trigger('change');
          }
        });
        return false;
      });

      // show free text field on certificate provider form when a statement type was chosen
      $('input:radio[name="certificateProviderStatementType"]').each(function(idx) {
        if($(this).attr('checked') != undefined) {
          if(idx == 0) {
            $(':input[name="certificateProviderKnowledgeOfDonor"]').closest('.form-element-textarea-cp-statement').show();
          }
          else {
            $(':input[name="certificateProviderProfessionalSkills"]').closest('.form-element-textarea-cp-statement').show();
          }
        }
      });
    });
  });


  // Form save button event handler. When response contains json object and
  // contains a success property, reload the page, otherwise, reload content
  // from response into the light box.

  body.on('click', '#form-save', function (e) {
    e.preventDefault();

    var button = $(this);
    var form = button.closest('form');
    var url = form.attr('action');

    // Show the spinner
    button.spinner();

    $.post(url, form.serialize(), function (resp) {
      var $lightbox;

      button.spinner('off');

      if(resp.success == undefined) {
        // has the login timed out?  if so, we must close the lightbox
        if (resp.toLowerCase().indexOf("sign in") != -1) {
          location.reload();
        } else {
          $lightbox = $('#form-lightbox').html(resp);

          // Mark as dirty
          $lightbox.find('form').data('dirty', true);

          OPGPopup.popup($lightbox, "form-popup", form);

          var donorCannotSign = $('#donor_cannot_sign').is(':checked');
          if (donorCannotSign) {
            $('#donorsignprompt').show();
          } else {
            $('#donorsignprompt').hide();
          }
        }
      }
      else {
        location.reload();
      }
    });
  });



    $('#load-pf').click(function(){
      $.get('/service/loadpf');
    });

    $('#load-hw').click(function(){
      $.get('/service/loadhw');
    });


  // Delete user account?

  body.on('click', '#delete-account', function(event){
    event.preventDefault();
    var deleteUrl = $(this).attr('href');
    if(confirm('Are you sure you want to delete this account?')) {
      $.ajax({
        url: deleteUrl,
        type: 'DELETE',
        success: function(resp){
          window.location.href="/";
        }
      });
    }
  });


  // Delete LPA?

  body.on('click', '.delete-lpa', function(event){
    event.preventDefault();
    if(confirm('Are you sure you want to delete this LPA?')) {
      var url = $(this).attr('href');
      window.location.href = url;
    }
  });


  // Delete person?

  body.on('click', 'a.delete-confirmation', function(event){
    event.preventDefault();
    var url=$(this).attr('href');
    if(confirm("Do you want to remove this person?")) {
      window.location.href=url;
    }
  });


  // Correspondents list

  body.on('change', 'select#correspondentList', function () {
    var url = $(this).val();
    if(url == '') {
      $(this).closest('form').find(':text').val('');
    }
    else {
      $(this).closest('form').find(':text, #email').each(function(){
    	  $(this).val('');
      });

      $.ajax({
        url: url,
        dataType:'json',
        success: function(resp) {

          for(var elmId in resp) {
            var field = $('#' + elmId),
                value = resp[elmId];

            // Insert each returned value into matching fields
            if (elmId === 'title') {
              lpa.updateSelectbox(field, value);
            } else {
              field.val(value).change();
            }
          }
        }

      });
    }
  });


  // Watch for changes to lightbox forms

  $('body').on('change', '#form-lightbox input, #form-lightbox select:not(#reusables)', function () {
    $(this).closest('form').data('dirty', true);
  });


  // Re-use a person's details

  $('body').on('change click', '#reusables', function (e) {

    var type = e.type,
        target = $(this)[0].tagName;

    // Prevent triggering on click of select box. Fix for Firefox (+ other possibly).
    if ((type === 'click' && target === 'A') || (type === 'change' && target === 'SELECT')) {

      e.preventDefault(); // for when triggered by a link

      var reusables = $(this),
          form = reusables.closest('form'),
          cont = !form.data('dirty'),
          url = reusables[0].tagName === 'A' ? reusables.data('service') : reusables.val();

      if (url.length) {

        if (!cont) {
          cont = confirm('This will replace the information which you have already entered, are you sure?');
        }

        if (cont) {

          $.get(url, function (resp) {

            // Reset all fields
            form[0].reset();
            form.data('dirty', true);

            // Populate each input field
            for (var elmId in resp) {
              var field = $('#' + elmId),
                  value = resp[elmId];

              // Insert each returned value into matching fields
              if (elmId === 'title') {
                lpa.updateSelectbox(field, value);
              } else {
                field.val(value).change();
              }
            }

            // Show any fields which were hidden
            $('.address-hideable').show();
          });

        } else {
          // In case the user chose not to overwrite the details, we must select something
          // neutral to allow re-selecting that option (on change)
          if (target === 'SELECT') {
            reusables.val(reusables.find('option:first').val());
          }
        }

      }

    }
  });


  // Scroll page to currently open section

  if($('section.current:not(#lpa-type)').length == 1) {
    window.onload = function() {
     setTimeout (function () {
          if(window.location.href.substring(window.location.href.lastIndexOf('/')+1) != 'lpa-type')
            window.scrollTo(0, $('section.current').offset().top - 53);
     }, 0);
    }
  }


    // Convert a text field to a 'Title' select box

    jQuery.fn.convertToTitleSelect = function() {
      var titles = ['Mr', 'Mrs', 'Miss', 'Ms', 'Dr'];
      if($(this).val()==''){
        $(this).attr('id', 'title-hide');
      } else if (!jQuery.inArray($(this).val(), titles)) {
        return;
      }
      titles.push("Other...");

      var el = $(this[0]);
      var textVal = $(el).val();

      // Build selectbox

      var titleSelectBox = $('<select id="title" name="title" class="title-select"></select>');
      $.each(titles, function(key, value) {
        titleSelectBox
          .append($('<option>', { value : value })
          .text(value));
      });

      $(el)
        .hide()
        .after(titleSelectBox);

      if (textVal == ''){
        $(el).val(titles[0]);
      } else if (jQuery.inArray( textVal, titles ) != -1){
        titleSelectBox.val(textVal);
      } else {
        $(el).show();
        titleSelectBox.hide();
      }

      $('.title-select')
        .change(function () {
          var value = $(this).val();
          if (value == 'Other...'){
            $(this).prev().val('').show().focus().attr('id','title');
            $(this).remove();
          } else {
            $(this).prev().val(value);
          }
        });
    };

    $('#title').convertToTitleSelect();





  // ====================================================================================
  // POPULATE WITH TEST DATA SCRIPTS

  function populateDate(id, date) {
        if ($(id).length > 0) $(id).val(date);
    }

  function getDateString() {
      var currentTime = new Date();
      var day = currentTime.getDate();
      var month = currentTime.getMonth() + 1;
      var year = currentTime.getFullYear();
      if (day < 10) {
          day = "0" + day;
      }
      if (month < 10) {
          month = "0" + month;
      }
      return day + "/" + month + "/" + year;
  }

  $('#populatetestdates').click(function (event) {
    event.preventDefault();
      var dateString = getDateString();

      populateDate('input#donor', dateString);
      populateDate('input#lifesustaining', dateString);
      for (i=0; i<5; i++) {
          populateDate('input#attorney_' + i, dateString);
          populateDate('input#certificateProvider_' + i, dateString);
          populateDate('input#replacementAttorney_' + i, dateString);
          populateDate('input#trustCorporation', dateString);
      }
  });

  $('#populatenotifiedtestdates').click(function (event) {
    event.preventDefault();
      var dateString = getDateString();

      for (i=0; i<5; i++) {
          populateDate('input#notifiedPerson_' + i, dateString);
      }
  });


  // ====================================================================================
  // Emphasised checkbox and radio button label styles

  var $emphasised = $('.emphasised input');
  $emphasised.filter(':checked').parent().addClass('checked');
  $emphasised.change(function() {
      $emphasised.parent().removeClass('checked');
      $emphasised.filter(':checked').parent().addClass('checked');
  });
});

