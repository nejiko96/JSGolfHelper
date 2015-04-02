  $ ->
    run = ->
      return unless $('#frm').valid()
      try
        cond = $('#cond').val()
        param = $('#param').val()
        expr = $('#expr').val()
        pre = 'arr=[];'
        exec = if param
          'arr.push({param:(' + param + '),value:(' + expr + ')});'
        else
          'arr.push(' + expr + ');'
        post = 'arr;'
        code = [pre, cond, exec, post].join "\n"
        $('#code').val code
        result = eval code
        $('#result').val JSON.stringify result
      catch error
        $('#frm').validate().showErrors 'expr': error
      return

    $('#cond,#param,#expr').keydown ->
      $('#result').val ""

    $('#expr').keyup ->
      $('#expr_len').text $('#expr').val().length

    $('#frm').validate(
      onsubmit: true
      onkeyup: false
      onfocusout: false
      errorElement: 'span'
      errorClass: 'help-block'
      highlight: (elem) ->
        $(elem).closest('.form-group').removeClass('has-success').addClass('has-error')
        return
      unhighlight: (elem) ->
        $(elem).closest('.form-group').removeClass('has-error').addClass('has-success')
        return
      errorPlacement: (error, element) ->
        if element.parent('.input-group').length
          error.insertAfter element.parent()
        else
          error.insertAfter element
        return
    )

    $('#frm').submit ->
      run()
      false
