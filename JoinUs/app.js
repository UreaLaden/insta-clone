import {faker} from '@faker-js/faker';
import dotenv from 'dotenv';
import express from 'express';
import mysql from 'mysql';
import bodyParser from 'body-parser';
import methodOverride from 'method-override';

dotenv.config();

const app = express();
app.use(express.static('./public'));
app.use(bodyParser.urlencoded({extended:true}));
app.set("view engine","ejs");

var connection = mysql.createConnection({
    host : process.env.HOST,
    user : process.env.USER,
    database : process.env.DB,
    password:process.env.PASS
});

const PORT = process.env.PORT;

app.get('/',(req,res) => {
    
    var query = "SELECT COUNT (*) AS Count FROM users";
    var amount = 0
    connection.query(query,(err,results)=>{
        if(err) throw err;
        amount = results[0].Count;
        res.render('index',{count:amount})
    });    
});

app.post('/register',(req,res)=>{

    var person = {
        username:req.body.email
    }
    var query = "INSERT INTO users SET ?"
    connection.query(query,person,(err,results)=>{
        if(err){
            console.log(err.message)
        } else{
            res.redirect('/');
        }
    });
});

app.get('/joke',(req,res)=>{
    var joke = "<strong>What do you call a dog that does magic traicks?</strong> <em>A labtracadabrador</em>"
    res.send(joke)
})

app.get('/insert-users',(req,res)=>{
    var data = [    ];
    for(var i=0;i<500;i++){
        data.push([
            faker.internet.email(),
            faker.date.past()
        ]);
    }   ;
    var query = 'INSERT INTO users (username,created_at) VALUES ?';
    
    connection.query(query,[data],(err,result)=>{
        console.log(err);
        console.log(result);
    });
    connection.end();

    res.send(`${data.length} Users inserted into DB`)
});

app.get("/random_num",(req,res)=>{
    var num = Math.floor(Math.random() * 10) + 1;
    res.send(`Your Lucky number is: ${num}`);
})

app.listen(PORT,() => {
    console.log(`App listening on http://localhost:${PORT}`)
})