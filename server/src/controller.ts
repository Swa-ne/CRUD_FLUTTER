import { Request, Response } from 'express';
import { addStudent, getStudent, getStudents, removeStudent, updateStudent } from './service';


export const getStudentsController = async (req: Request, res: Response) => {
    try {
        const students = await getStudents()
        return res.status(200).json({ 'message': students });
    } catch (error) {
        return res.status(500).json({ 'error': 'Internal Server Error' });
    }
};
export const getStudentController = async (req: Request, res: Response) => {
    try {
        const { user_id } = req.params;
        if (!user_id) return res.status(404).json({ 'error': "Student not found" });

        const student = await getStudent(user_id);
        return res.status(200).json({ 'message': student });
    } catch (error) {
        return res.status(500).json({ 'error': 'Internal Server Error' });
    }
};
export const addStudentController = async (req: Request, res: Response) => {
    try {
        const { first_name, last_name, course, year, enrolled } = req.body;

        const requiredFields = {
            first_name,
            last_name,
            course,
            year,
            enrolled
        };

        const updatedKey: { [key: string]: string } = {
            first_name: "First Name",
            last_name: "Last Name",
            course: "Course",
            year: "Year",
            enrolled: "Enrolled"
        };

        for (const [key, value] of Object.entries(requiredFields)) {
            if (value == null) {
                return res.status(400).json({ error: `${updatedKey[key]} is required and cannot be null or undefined.` });
            }
        }
        const student = await addStudent(first_name, last_name, course, year, enrolled);
        return res.status(200).json({ 'message': student });
    } catch (error) {
        return res.status(500).json({ 'error': 'Internal Server Error' });
    }
};
export const updateStudentController = async (req: Request, res: Response) => {
    try {
        const { user_id } = req.params;
        const { first_name, last_name, course, year, enrolled } = req.body;
        if (!user_id) return res.status(404).json({ 'error': "Student not found" });

        const student = await updateStudent(user_id, first_name, last_name, course, year, enrolled);
        return res.status(200).json({ 'message': student });
    } catch (error) {
        return res.status(500).json({ 'error': 'Internal Server Error' });
    }
};
export const removeStudentController = async (req: Request, res: Response) => {
    try {
        const { user_id } = req.params;
        if (!user_id) return res.status(404).json({ 'error': "Student not found" });

        const result = await removeStudent(user_id)
        return res.status(200).json({ 'message': result });
    } catch (error) {
        return res.status(500).json({ 'error': 'Internal Server Error' });
    }
};