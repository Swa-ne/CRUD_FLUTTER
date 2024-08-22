import mongoose, { Schema, Document, ObjectId } from 'mongoose';

export interface StudentSchemaInterface extends Document {
    _id: ObjectId,
    first_name: string,
    last_name: string,
    course: string,
    year: string,
    enrolled: boolean,
}

const StudentSchema: Schema = new Schema({
    first_name: {
        type: String,
        required: [true, "Please enter student's first name."],
    },
    last_name: {
        type: String,
        required: [true, "Please enter student's last name."],
    },
    course: {
        type: String,
        required: [true, "Please enter student's course."],
    },
    year: {
        type: String,
        required: [true, "Please enter student's full name."],
    },
    enrolled: {
        type: Boolean,
        required: [true, "Please enter student's enrollment status."],
    },
});

export const Student = mongoose.model<StudentSchemaInterface>("Student", StudentSchema)
