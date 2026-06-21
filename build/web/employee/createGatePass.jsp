<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String role = (String)session.getAttribute("role");
    if(role == null || !role.equals("Employee")){
        response.sendRedirect("../login.jsp");
        return;
    }
    String name = (String)session.getAttribute("name");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Create Gate Pass</title>
    <style>
        body { font-family: Arial; margin: 0; background: #f0f2f5; }
        .header { background-color: #27ae60; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h2 { margin: 0; }
        .back { background: white; color: #27ae60; padding: 8px 15px; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .container { padding: 20px; max-width: 650px; margin: auto; }
        .form-box { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-box h3 { margin-top: 0; color: #27ae60; border-bottom: 2px solid #27ae60; padding-bottom: 10px; }
        label { display: block; margin: 12px 0 4px 0; font-weight: bold; color: #555; }
        input, select, textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; font-size: 14px; }
        textarea { height: 70px; }
        button { width: 100%; padding: 12px; background: #27ae60; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; margin-top: 20px; }
        button:hover { background: #219a52; }
        .success { background: #d4edda; color: #155724; padding: 10px; border-radius: 5px; margin-bottom: 15px; text-align: center; }
        .error-msg { background: #f8d7da; color: #721c24; padding: 10px; border-radius: 5px; margin-bottom: 15px; text-align: center; }
        .section { background: #f8f9fa; padding: 15px; border-radius: 8px; margin-top: 10px; border-left: 4px solid #27ae60; }
        .section-title { font-weight: bold; color: #27ae60; margin-bottom: 10px; font-size: 15px; }
        .gp-type-box { display: flex; gap: 15px; margin: 10px 0; }
        .gp-type-btn { flex: 1; padding: 12px; border: 2px solid #ddd; border-radius: 8px; cursor: pointer; text-align: center; background: white; font-size: 14px; font-weight: bold; transition: all 0.3s; }
        .gp-type-btn.active { border-color: #27ae60; background: #e8f8f0; color: #27ae60; }
    </style>
    <script>
        function selectType(type) {
            document.getElementById('gp_type').value = type;
            
            if(type == 'Returnable') {
                document.getElementById('returnable-fields').style.display = 'block';
                document.getElementById('nonreturnable-fields').style.display = 'none';
                document.getElementById('btn-returnable').className = 'gp-type-btn active';
                document.getElementById('btn-nonreturnable').className = 'gp-type-btn';
            } else {
                document.getElementById('returnable-fields').style.display = 'none';
                document.getElementById('nonreturnable-fields').style.display = 'block';
                document.getElementById('btn-returnable').className = 'gp-type-btn';
                document.getElementById('btn-nonreturnable').className = 'gp-type-btn active';
            }
        }

        function submitForm() {
            var type = document.getElementById('gp_type').value;
            
            if(type == 'Returnable') {
                var mat = document.getElementById('r_material_name').value;
                var qty = document.getElementById('r_quantity').value;
                var date = document.getElementById('r_date').value;
                var time = document.getElementById('r_time').value;
                
                if(mat == '' || qty == '' || date == '' || time == '') {
                    alert('Please fill all required fields!');
                    return false;
                }
            } else {
                var mat = document.getElementById('nr_material_name').value;
                var qty = document.getElementById('nr_quantity').value;
                var date = document.getElementById('nr_date').value;
                var time = document.getElementById('nr_time').value;
                
                if(mat == '' || qty == '' || date == '' || time == '') {
                    alert('Please fill all required fields!');
                    return false;
                }
            }
            
            document.getElementById('gatePassForm').submit();
            return true;
        }
    </script>
</head>
<body>
    <div class="header">
        <h2>📝 Create Gate Pass</h2>
        <a href="dashboard.jsp" class="back">← Back</a>
    </div>
    <div class="container">
        <div class="form-box">
            <h3>📋 Gate Pass Request Form</h3>

            <% if(request.getParameter("success") != null){ %>
                <div class="success">✅ Gate Pass Created! Waiting for Admin Approval.</div>
            <% } %>
            <% if(request.getParameter("error") != null){ %>
                <div class="error-msg">❌ Error! Please try again.</div>
            <% } %>

            <form action="../CreateGatePassServlet" method="post" id="gatePassForm">
                <input type="hidden" name="gp_type" id="gp_type" value="Returnable"/>

                <label>GP Type:</label>
                <div class="gp-type-box">
                    <div class="gp-type-btn active" id="btn-returnable" onclick="selectType('Returnable')">
                        🔄 Returnable
                    </div>
                    <div class="gp-type-btn" id="btn-nonreturnable" onclick="selectType('Non-Returnable')">
                        📦 Non Returnable
                    </div>
                </div>

                <!-- RETURNABLE FIELDS -->
                <div id="returnable-fields">
                    <div class="section">
                        <div class="section-title">🔄 Returnable Gate Pass</div>

                        <label>Material Name: *</label>
                        <input type="text" id="r_material_name" name="material_name" placeholder="Enter material name"/>

                        <label>Quantity: *</label>
                        <input type="number" id="r_quantity" name="quantity" placeholder="Enter quantity"/>

                        <label>Employee Name:</label>
                        <input type="text" name="employee_name" value="<%=name%>"/>

                        <label>Department:</label>
                        <select name="department">
                            <option value="">Select Department</option>
                            <option value="IT">IT</option>
                            <option value="HR">HR</option>
                            <option value="Finance">Finance</option>
                            <option value="Production">Production</option>
                            <option value="Maintenance">Maintenance</option>
                            <option value="Store">Store</option>
                        </select>

                        <label>Purpose:</label>
                        <textarea name="purpose" placeholder="Enter purpose"></textarea>

                        <label>Date: *</label>
                        <input type="date" id="r_date" name="date"/>

                        <label>Expected Return Date:</label>
                        <input type="date" name="expected_return_date"/>

                        <label>Time: *</label>
                        <input type="time" id="r_time" name="time"/>

                        <label>Vehicle No:</label>
                        <input type="text" name="vehicle_no" placeholder="Ex: AP20AT1715"/>

                        <label>Agency Name:</label>
                        <input type="text" name="agency_name" placeholder="Enter agency name"/>

                        <label>Agency Phone Number:</label>
                        <input type="text" name="agency_phone" placeholder="Enter phone number"/>

                        <label>Address:</label>
                        <textarea name="address" placeholder="Enter address"></textarea>
                    </div>
                </div>

                <!-- NON RETURNABLE FIELDS -->
                <div id="nonreturnable-fields" style="display:none;">
                    <div class="section">
                        <div class="section-title">📦 Non Returnable Gate Pass</div>

                        <label>Material Name: *</label>
                        <input type="text" id="nr_material_name" name="nr_material_name" placeholder="Enter material name"/>

                        <label>Quantity: *</label>
                        <input type="number" id="nr_quantity" name="nr_quantity" placeholder="Enter quantity"/>

                        <label>Employee Name:</label>
                        <input type="text" name="nr_employee_name" value="<%=name%>"/>

                        <label>Department:</label>
                        <select name="nr_department">
                            <option value="">Select Department</option>
                            <option value="IT">IT</option>
                            <option value="HR">HR</option>
                            <option value="Finance">Finance</option>
                            <option value="Production">Production</option>
                            <option value="Maintenance">Maintenance</option>
                            <option value="Store">Store</option>
                        </select>

                        <label>Purpose:</label>
                        <textarea name="nr_purpose" placeholder="Enter purpose"></textarea>

                        <label>Date: *</label>
                        <input type="date" id="nr_date" name="nr_date"/>

                        <label>Time: *</label>
                        <input type="time" id="nr_time" name="nr_time"/>

                        <label>Vehicle No:</label>
                        <input type="text" name="nr_vehicle_no" placeholder="Ex: AP20AT1715"/>

                        <label>Agency Name:</label>
                        <input type="text" name="nr_agency_name" placeholder="Enter agency name"/>

                        <label>Agency Phone Number:</label>
                        <input type="text" name="nr_agency_phone" placeholder="Enter phone number"/>

                        <label>Address:</label>
                        <textarea name="nr_address" placeholder="Enter address"></textarea>
                    </div>
                </div>

                <button type="button" onclick="submitForm()">
                    Submit Gate Pass Request 🚀
                </button>
            </form>
        </div>
    </div>
</body>
</html>