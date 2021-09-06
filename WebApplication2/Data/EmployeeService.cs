using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApplication2.Data
{
    public class EmployeeService
    {
        private readonly ApplicationDbContext _db;

        public EmployeeService(ApplicationDbContext db)
        {
            _db = db;
        }

        //Get All Data
        public List<EmployeeInfo> GetEmployees()
        {
            //var empList = _db.Employees.ToList();
            //return empList;
            var empList = _db.Employees.FromSqlRaw<EmployeeInfo>("SP_GetEmployees").ToList();
            return empList;
        }

        //Insert employe info
        public string Create(EmployeeInfo objEmployee)
        {
            //_db.Employees.Add(objEmployee);
            //_db.SaveChanges();
            List<SqlParameter> parms = new List<SqlParameter>
    { 
        // Create parameters    
        new SqlParameter { ParameterName = "@empName", Value = objEmployee.Name },
        new SqlParameter { ParameterName = "@City", Value =  objEmployee.City },
         new SqlParameter { ParameterName = "@Country", Value = objEmployee.Country },
        new SqlParameter { ParameterName = "@Gender", Value = objEmployee.Gender },
    };
            _db.Database.ExecuteSqlRaw("EXEC SP_InsertEmployee @empName, @City, @Country, @Gender", parms.ToArray());
            return "Save Successfully";
        }

        //Get Employee By ID
        public EmployeeInfo GetEmployeeById(int id)
        {
            //EmployeeInfo employee = _db.Employees.FirstOrDefault(s => s.EmployeeId == id);
            //return employee;


            var employee = _db.Employees.FromSqlRaw<EmployeeInfo>("SP_GetEmployeeById {0}", id).ToList().SingleOrDefault();
            return employee;
        }

        //Update Employee Info

        public string UpdateEmployee(EmployeeInfo objEmployee)
        {
            //_db.Employees.Update(objEmployee);
            // _db.SaveChanges();
            _db.Database.ExecuteSqlRaw("EXEC SP_UpdateEmployee {0}, {1},{2},{3},{4}", objEmployee.EmployeeId, objEmployee.Name, objEmployee.City, objEmployee.Country, objEmployee.Gender);

            return "Update Successfully";
        }

        //Delete Employee

        public string DeleteEmpInfo(EmployeeInfo objEmployee)
        {
            //_db.Remove(objEmployee);
            //_db.SaveChanges();
            _db.Database.ExecuteSqlRaw("EXEC SP_DeleteEmployee {0}", objEmployee.EmployeeId);
            return "Delete Successfully";
        }
    }
}
