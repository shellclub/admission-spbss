const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcryptjs');

const prisma = new PrismaClient();

async function main() {
    console.log('🌱 Starting seed...');

    // Hash password 'password123' (OR match what the user expects)
    // User complaint mentioned login error. Default stack password is 'password123'.
    // Let's set user 'admin' with password 'password123'.
    const hashedPassword = await bcrypt.hash('password123', 10);

    const admin = await prisma.user.upsert({
        where: { username: 'admin' },
        update: {
            password: hashedPassword, // Ensure password is correct if user exists
            role: 'admin'
        },
        create: {
            username: 'admin',
            password: hashedPassword,
            name: 'System Admin',
            role: 'admin',
        },
    });

    console.log('✅ Admin user seeded/updated:', admin.username);
}

main()
    .then(async () => {
        await prisma.$disconnect();
    })
    .catch(async (e) => {
        console.error('❌ Seed failed:', e);
        await prisma.$disconnect();
        process.exit(1);
    });
