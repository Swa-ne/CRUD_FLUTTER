import { Document, ObjectId } from "mongoose";
import { Student, StudentSchemaInterface } from "./model";

interface CustomDeleteResult {
    acknowledged: boolean;
    deletedCount: number;
};

export const getStudents = async (): Promise<StudentSchemaInterface[] | null> => {
    try {
        const students: StudentSchemaInterface[] | null = await Student.find();
        return students;
    } catch (error) {
        return null;
    }
};
export const getStudent = async (user_id: string): Promise<StudentSchemaInterface | null> => {
    try {
        const student: StudentSchemaInterface | null = await Student.findById(user_id);
        return student;
    } catch (error) {
        return null;
    }
};
export const addStudent = async (first_name: string, last_name: string, course: string, year: string, enrolled: boolean): Promise<Document<unknown, {}, StudentSchemaInterface> & StudentSchemaInterface & Required<{ _id: ObjectId; }> | null> => {
    try {
        const student: Document<unknown, {}, StudentSchemaInterface> & StudentSchemaInterface & Required<{ _id: ObjectId; }> | null = await new Student({
            first_name,
            last_name,
            course,
            year,
            enrolled
        }).save();
        return student;
    } catch (error) {
        return null;
    }
};
export const updateStudent = async (user_id: string, first_name: string, last_name: string, course: string, year: string, enrolled: boolean): Promise<StudentSchemaInterface | null> => {
    try {
        const student: StudentSchemaInterface | null = await Student.findOneAndUpdate({ _id: user_id }, {
            first_name,
            last_name,
            course,
            year,
            enrolled
        });
        return student;
    } catch (error) {
        return null;
    }
};
export const removeStudent = async (user_id: string): Promise<CustomDeleteResult | null> => {
    try {
        const student: CustomDeleteResult = await Student.deleteOne({ _id: user_id });
        return student;
    } catch (error) {
        return null;
    }
};