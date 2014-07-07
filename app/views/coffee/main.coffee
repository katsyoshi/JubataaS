@postYourParamsLearn = () ->
  name = $('#your-name').val()
  weight = $('#your-weight').val()
  meals = $('#your-meals').val()
  foto = $('#your-photo').val()

  updateData = {
    types: {weight: 'num', meals: 'str', photo: 'str' },
    data: [{weight: weight, meals: meals, photo: foto}],
    label: {0: name}
  }

  $.ajax({
    type: 'post',
    url: '/classifier/hoge/update.json',
    data: JSON.stringify(updateData),
    contentType: 'application/json',
    dataType: 'json'
  })

@postYourParamsAnalyze = () ->
  weight = $('#your-weight').val()
  meals = $('#your-meals').val()
  foto = $('#your-photo').val()

  analyzeData = {
    types: {weight: 'num', meals: 'str', photo: 'str' },
    data: [{weight: weight, meals: meals, photo: foto}]
  }

  $.ajax({
    type: 'post',
    url: '/classifier/hoge.json',
    data: JSON.stringify(analyzeData),
    contentType: 'application/json',
    dataType: 'json',
    success: (json) ->
      for obj in json
        $('#calc-result').text('')
        for result in obj
          $('#calc-result').append("label: " + result.label + " score: " + result.score + "<br>")
  })
