function validateRegister() {
  var name = document.getElementById('name').value.trim();
  var email = document.getElementById('email').value.trim();
  var password = document.getElementById('password').value;
  if (name.length < 2) { alert('Enter a valid name'); return false; }
  if (!email.includes('@') || email.length < 5) { alert('Enter valid email'); return false; }
  if (password.length < 6) { alert('Password must be at least 6 characters'); return false; }
  return true;
}
