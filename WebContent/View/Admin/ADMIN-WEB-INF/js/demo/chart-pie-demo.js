// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

// Pie Chart Example
var jay = document.getElementById("jayMonthCalls").value;
var axita = document.getElementById("axitaMonthCalls").value;
var kishan = document.getElementById("kishanMonthCalls").value;
var henry = document.getElementById("henryMonthCalls").value;
var nilesh = document.getElementById("nileshMonthCalls").value;

var ctx = document.getElementById("myPieChart");
var myPieChart = new Chart(ctx, {
  type: 'doughnut',
  data: {
    labels: ["Jay", "Axita", "Kishan", "Henry", "Nilesh"],
    datasets: [{
      data: [jay, axita, kishan, henry, nilesh],
      backgroundColor: ['#4e73df', '#1cc88a', '#36b9cc', '#f6c23e', '#5a5c69'],
      hoverBackgroundColor: ['#2e59d9', '#17a673', '#2c9faf'],
      hoverBorderColor: "rgba(234, 236, 244, 1)",
    }],
  },
  options: {
    maintainAspectRatio: false,
    tooltips: {
      backgroundColor: "rgb(255,255,255)",
      bodyFontColor: "#858796",
      borderColor: '#dddfeb',
      borderWidth: 1,
      xPadding: 15,
      yPadding: 15,
      displayColors: false,
      caretPadding: 10,
    },
    legend: {
      display: false
    },
    cutoutPercentage: 80,
  },
});
