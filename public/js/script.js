


fetch("../api/add", {
    method: 'POST',
    cache: 'no-cache',
    credentials: 'same-origin',
    headers: {
        'Content-Type': 'application/json'
    },
    body: JSON.stringify({ title: "test", content: "from javascript" })
}).then((result) => {
    result.json().then(json => {
        console.log(json);
    })

});
