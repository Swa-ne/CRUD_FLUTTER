import express, { Request, Response } from 'express';
import mongoose from 'mongoose';
import bodyParser from "body-parser"
import cors from 'cors';
import cookieParser from 'cookie-parser';
import dotenv from "dotenv"
import { addStudentController, getStudentController, getStudentsController, removeStudentController, updateStudentController } from './controller';
dotenv.config()



const app = express();

const port = 3000;

const MONGODB_CONNECTION: any = process.env.MONGODB_CONNECTION;
mongoose
    .connect(MONGODB_CONNECTION)
    .then(() => {
        console.log('connected to MongoDB');
    })
    .catch((error) => {
        console.log('Internal Server Error');
    });

app.use(
    cors({
        origin: [process.env.CLIENT_URL as string, "*"],
        credentials: true,
    })
);

app.use(express.json())
app.use(
    bodyParser.urlencoded({
        extended: true,
    }),
);
app.use(cookieParser())

app.get("/students", getStudentsController);
app.get("/student/:user_id", getStudentController);
app.post("/add", addStudentController);
app.put("/update/:user_id", updateStudentController);
app.delete("/delete/:user_id", removeStudentController);


app.get('/', (req: Request, res: Response) => {
    res.send('Hello from your Node.js Express server!');
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});