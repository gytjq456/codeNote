const input = document.querySelector('#input');

function checker() {
  const words = document.querySelectorAll('.word');
  if (words.length === 0) {
    alert('Success!👏');
    if(confirm('retry?')) {
      window.location.reload();
    }
  }
}

// 여기에 코드를 작성해 주세요.
function removeWords(){
  
  const word = document.querySelector(`[data-word="${input.value}"]`);
  if (word) {
    word.remove();
    checker();
  }

  input.value = '';
}
input.addEventListener('change', removeWords);