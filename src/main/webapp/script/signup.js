function check() {
    let pass = document.getElementById("pword");
    let cnfpass = document.getElementById("cnfpword");
    let phone = document.getElementById("phone");
console.log(phone.value.length);




    if (phone.value.length !== 10) 
    {

        Swal.fire({
  title: "Error",
  text: "Phone Number invalid",
  icon: "error"
});
        event.preventDefault();	
    } 
    else if (pass.value.length < 8) 
    {

        Swal.fire({
  title: "Error",
  text: "Password length must be greater than 8",
  icon: "error"
});
        event.preventDefault();
    } 
    else if (pass.value !== cnfpass.value) 
    {
        Swal.fire({
  title: "Error",
  text: "Passwords do not match",
  icon: "error"
});
        event.preventDefault();
    }

}