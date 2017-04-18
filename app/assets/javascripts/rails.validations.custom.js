ClientSideValidations.validators.remote['check_uniqueness'] = function(element, options){
  if ($.ajax({
    url: '/validators/user',
    data: { email: element.val() },
    // async *must* be false
    async: false
  }).status == 200) { return options.message; }
}
