import { NextResponse } from 'next/server';
import { prisma } from '@/lib/prisma';

export const dynamic = 'force-dynamic';

export async function GET() {
    try {
        // Test database connection
        const userCount = await prisma.user.count();
        const users = await prisma.user.findMany({ 
            take: 5,
            select: { username: true, role: true } 
        });
        
        return NextResponse.json({ 
            status: "ok", 
            message: "Database connected successfully", 
            userCount,
            users,
            environment: {
                NEXTAUTH_URL: process.env.NEXTAUTH_URL,
                NEXTAUTH_SECRET_SET: !!process.env.NEXTAUTH_SECRET,
                NODE_ENV: process.env.NODE_ENV,
                DB_HOST: process.env.DB_HOST // Safe to show host
            }
        });
    } catch (e) {
        return NextResponse.json({ 
            status: "error", 
            message: e.message, 
            stack: e.stack 
        }, { status: 500 });
    }
}
