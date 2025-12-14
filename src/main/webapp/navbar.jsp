<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Security Check (ensuring only logged-in administrators can view)
    if (session == null || session.getAttribute("isLoggedIn") == null ||
            !"ADMIN".equals(session.getAttribute("userRole"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    // Get the current page path to determine the active link
    String path = request.getRequestURI().substring(request.getContextPath().length());
    String username = (String) session.getAttribute("username");
    String basePath = request.getContextPath();
%>

<nav class="bg-white border-b border-slate-200 fixed top-0 w-full z-30 shadow-sm">
    <div class="px-6 py-3">
        <div class="flex items-center justify-between">

            <div class="flex items-center justify-start">
                <span class="self-center text-xl font-semibold whitespace-nowrap text-slate-900">
                    Administrator Panel
                </span>
            </div>

            <div class="hidden md:flex flex-1 justify-center space-x-2">

                <%-- Helper function to check if a link is active --%>
                <%!
                    private String isActive(String currentPath, String linkPath) {
                        // Sharp Cyan border for active link, no border-radius
                        return currentPath.contains(linkPath) ? "text-cyan-600 font-semibold bg-slate-100 rounded-md" : "text-slate-600 hover:text-cyan-600 hover:bg-slate-50";
                    }
                %>

                <a href="<%= basePath %>/dashboard.jsp" class="py-2 px-4 transition duration-150 ease-in-out <%= isActive(path, "/dashboard.jsp") %>">
                    Dashboard
                </a>

                <a href="<%= basePath %>/admin/courses.jsp" class="py-2 px-4 transition duration-150 ease-in-out <%= isActive(path, "/admin/courses.jsp") %>">
                    Courses
                </a>

                <a href="<%= basePath %>/admin/students.jsp" class="py-2 px-4 transition duration-150 ease-in-out <%= isActive(path, "/admin/students.jsp") %>">
                    Students
                </a>
            </div>

            <div class="flex items-center">
                <div class="flex items-center ml-3">
                    <span class="text-sm font-medium text-slate-700 mr-4 hidden sm:inline">
                        Welcome, <%= username != null ? username.split("@")[0] : "Admin" %>
                    </span>

                    <a href="<%= basePath %>/LogoutServlet" class="text-slate-700 border border-slate-300 bg-white hover:bg-slate-100 focus:ring-4 focus:ring-slate-200 font-medium rounded-md text-sm px-4 py-2 transition duration-150 ease-in-out">
                        <svg class="w-4 h-4 inline mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3v-4a3 3 0 013-3h3m2-3V4a3 3 0 013-3h4a3 3 0 013 3v4"></path></svg>
                        Logout
                    </a>
                </div>
            </div>

        </div>
    </div>
</nav>

<div class="h-14"></div>