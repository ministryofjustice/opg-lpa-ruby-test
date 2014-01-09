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


  // Scroll page to currently open section

  if($('section.current:not(#lpa-type)').length == 1) {
    window.onload = function() {
     setTimeout (function () {
          if(window.location.href.substring(window.location.href.lastIndexOf('/')+1) != 'lpa-type')
            window.scrollTo(0, $('section.current').offset().top - 53);
     }, 0);
    }
  }


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

