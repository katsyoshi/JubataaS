@postYourParamsLearn = () ->
  name = $('#your-name').val()
  weight = $('#your-weight').val()
  meals = $('#your-meals').val()
  foto = $('#your-photo').val()

  updateData = {
    types: {name: 'str', weight: 'num', meals: 'str', photo: 'str' },
    data: [{name: name, weight: weight, meals: meals, photo: foto}],
    label: {0: name}
  }

  $.ajax({
    type: 'post',
    url: '/classifier/update',
    data: JSON.stringify(updateData),
    contentType: 'application/json',
    dataType: 'json'
  })

@postYourParamsAnalyze = () ->
  name = $('#your-name').val()
  weight = $('#your-weight').val()
  meals = $('#your-meals').val()
  foto = $('#your-photo').val()

  analyzeData = {
    types: {name: 'str', weight: 'num', meals: 'str', photo: 'str' },
    data: [{name: name, weight: weight, meals: meals, photo: foto}]
  }

  $.ajax({
    type: 'post',
    url: '/classifier',
    data: JSON.stringify(analyzeData),
    contentType: 'application/json',
    dataType: 'json'
    success: (json) ->
      for obj in json
        for result in obj
          $('#calc-result').text("label:" + result['label'] + "score:" + result['score'])
  })
