
import { NextResponse } from 'next/server';
import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';

const prisma = new PrismaClient();

export async function GET() {
    // SECURITY: Only allow in development
    if (process.env.NODE_ENV !== 'development') {
        return NextResponse.json({ error: 'Forbidden in production' }, { status: 403 });
    }

    try {
        const hashedPassword = await bcrypt.hash('admin123', 10);

        // Check if admin exists
        const existingUser = await prisma.user.findUnique({
            where: { username: 'admin' }
        });

        if (!existingUser) {
            await prisma.user.create({
                data: {
                    username: 'admin',
                    password: hashedPassword,
                    name: 'Administrator',
                    role: 'admin'
                }
            });
            return NextResponse.json({ success: true, message: 'Admin user created' });
        }

        // Optional: Update password if needed
        // await prisma.user.update({ where: { username: 'admin' }, data: { password: hashedPassword } });

        return NextResponse.json({ success: true, message: 'Admin user already exists' });
    } catch (error) {
        return NextResponse.json({ success: false, error: error.message }, { status: 500 });
    }
}
