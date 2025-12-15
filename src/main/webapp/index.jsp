<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Horizon Tech | University Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen font-sans flex flex-col">

<header class="bg-white border-b border-slate-200 py-4">
    <div class="container mx-auto px-6 flex justify-between items-center">
        <div class="flex items-center gap-2">
            <div class="bg-cyan-600 text-white p-1.5 rounded font-bold text-xl">HT</div>
            <span class="text-xl font-bold text-slate-800 tracking-tight">Horizon Tech</span>
        </div>
        <a href="login.jsp" class="text-sm font-medium text-slate-600 hover:text-cyan-600 transition">Log In</a>
    </div>
</header>

<main class="flex-grow container mx-auto px-6 py-16 max-w-5xl">

    <div class="text-center mb-16">
        <h1 class="text-4xl md:text-5xl font-extrabold text-slate-900 mb-6 tracking-tight">
            Academic Management <br/>
            <span class="text-cyan-600">Simplified.</span>
        </h1>
        <p class="text-lg text-slate-600 max-w-2xl mx-auto leading-relaxed">
            A complete Jakarta EE solution for managing university courses, student enrollments, and academic records.
            Built with Servlets, JSP, Hibernate, and Tailwind CSS.
        </p>

        <div class="mt-10 flex flex-col sm:flex-row justify-center gap-4">
            <a href="login.jsp"
               class="px-8 py-3 bg-cyan-600 text-white font-bold rounded-lg shadow-md hover:bg-cyan-700 hover:shadow-lg transition transform hover:-translate-y-0.5">
                Get Started &rarr;
            </a>
            <a href="test-db"
               class="px-8 py-3 bg-white text-slate-700 font-bold rounded-lg border border-slate-300 hover:bg-slate-50 hover:text-slate-900 transition">
                Test Database Connection
            </a>
        </div>
    </div>

    <div class="bg-white rounded-2xl shadow-sm border border-slate-200 p-8 md:p-10">
        <div class="text-center mb-8">
            <h2 class="text-2xl font-bold text-slate-900">Demo Accounts</h2>
            <p class="text-slate-500">Use these credentials to test the different user roles.</p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">

            <div class="bg-slate-50 rounded-xl p-6 border border-slate-200 relative group hover:border-indigo-300 transition">
                <div class="absolute top-0 right-0 bg-indigo-100 text-indigo-700 text-xs font-bold px-3 py-1 rounded-bl-lg rounded-tr-lg">
                    ADMINISTRATOR
                </div>
                <h3 class="font-bold text-slate-900 mb-4 flex items-center">
                    <svg class="w-5 h-5 mr-2 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path></svg>
                    Admin Access
                </h3>
                <div class="space-y-3 font-mono text-sm">
                    <div class="flex justify-between items-center bg-white p-2 rounded border border-slate-200">
                        <span class="text-slate-400 select-none">Email:</span>
                        <span class="text-slate-800 select-all">admin@horizon-tech.tn</span>
                    </div>
                    <div class="flex justify-between items-center bg-white p-2 rounded border border-slate-200">
                        <span class="text-slate-400 select-none">Pass:</span>
                        <span class="text-slate-800 select-all">adminpass</span>
                    </div>
                </div>
                <p class="text-xs text-slate-500 mt-4">Access dashboard, manage students, courses, and view analytics.</p>
            </div>

            <div class="bg-slate-50 rounded-xl p-6 border border-slate-200 relative group hover:border-cyan-300 transition">
                <div class="absolute top-0 right-0 bg-cyan-100 text-cyan-700 text-xs font-bold px-3 py-1 rounded-bl-lg rounded-tr-lg">
                    STUDENT
                </div>
                <h3 class="font-bold text-slate-900 mb-4 flex items-center">
                    <svg class="w-5 h-5 mr-2 text-cyan-500" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"></path></svg>
                    Student Portal
                </h3>
                <div class="space-y-3 font-mono text-sm">
                    <div class="flex justify-between items-center bg-white p-2 rounded border border-slate-200">
                        <span class="text-slate-400 select-none">Email:</span>
                        <span class="text-slate-800 select-all">omar.waness@example.com</span>
                    </div>
                    <div class="flex justify-between items-center bg-white p-2 rounded border border-slate-200">
                        <span class="text-slate-400 select-none">Pass:</span>
                        <span class="text-slate-800 select-all">password</span>
                    </div>
                </div>
                <p class="text-xs text-slate-500 mt-4">View enrolled courses, check GPA, and see personal academic profile.</p>
            </div>

        </div>
    </div>
</main>

<footer class="bg-white border-t border-slate-200 py-8 mt-auto">
    <div class="container mx-auto px-6 text-center text-slate-400 text-sm">
        <p>&copy; 2024 Horizon Tech. Java EE Project.</p>
    </div>
</footer>

</body>
</html>