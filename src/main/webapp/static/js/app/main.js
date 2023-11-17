document.getElementById('review-form').addEventListener('submit', function(event) {
    event.preventDefault();  

    let restaurantName = document.getElementById('restaurant-name').value;
    let rating = document.getElementById('rating').value;
    let review = document.getElementById('review').value;  
    let restaurant_id = document.getElementById('restaurant-id').value; 

    var date = new Date();

    var formData = {
      restaurantName: restaurantName,
      rating: rating,
      review: review,
      date: date,
      restaurant_id: restaurant_id
    };

    let request = new XMLHttpRequest();
    request.open('POST', 'https://gablw7xnf8.execute-api.us-east-1.amazonaws.com/default/lambda_function', true);
    request.setRequestHeader('Content-Type', 'application/json');
    request.send(JSON.stringify(formData));
  
    
    request.onload = function() {
      if (request.status === 200) {
        alert('Reseña enviada exitosamente');
        console.log(request)
      } else {
        alert('Error al enviar la reseña');
        console.log(request)
      }
    };

});
  