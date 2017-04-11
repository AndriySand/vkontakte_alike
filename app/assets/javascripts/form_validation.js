function validateUser(){
  answer = validateForm('#user_name', 4, 'Your name must be at least 4 characters long');
  answer = validateForm('#user_password', 6, 'Your password must be at least 6 characters long');
  answer = validateForm('#user_password_confirmation', 6, 'Your password confirmation must be at least 6 characters long');
  return answer;
}

function validateArticle(){
  return validateForm('#article_title', 8, 'Article Title must be at least 8 characters long');
}

function validateForm(selector, length, msg){
  if($(selector).prop('value').length < length){
    alert(msg);
    return false;
  }
}
