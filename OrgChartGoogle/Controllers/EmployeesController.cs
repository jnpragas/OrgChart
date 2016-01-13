using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using OrgChartGoogle.Models;

namespace OrgChartGoogle.Controllers
{
    public class EmployeesController : ApiController
    {
        private OrgChartGoogleContext db = new OrgChartGoogleContext();

        // GET api/Employees
        public IQueryable<Employee> GetEmployees()
        {
            return db.Employees;
        }

        // GET api/Employees/5
        [ResponseType(typeof(Employee))]
        public async Task<IHttpActionResult> GetEmployee(int id)
        {
            Employee employee = await db.Employees.FindAsync(id);
            if (employee == null)
            {
                return NotFound();
            }

            return Ok(employee);
        }

        // GET api/Employees/5
        [ResponseType(typeof(Employee))]
        public async Task<IHttpActionResult> GetDownEmployee(int id)
        {
            Employee employee = await db.Employees.FindAsync(id);
            if (employee == null)
            {
                return NotFound();
            }

            string nodeId = employee.nodeId;

            IQueryable<Employee> employeeQuery =
                from emp in db.Employees
                where emp.parentId == nodeId || emp.id == id
                select emp;

            return Ok(employeeQuery);
        }

        // GET api/Employees/5
        [ResponseType(typeof(Employee))]
        public async Task<IHttpActionResult> GetUpEmployee(int id)
        {
            Employee employee = await db.Employees.FindAsync(id);
            if (employee == null)
            {
                return NotFound();
            }

            string parentId = employee.parentId;

            IQueryable<Employee> employeeQuery =
                from emp in db.Employees
                where emp.parentId == parentId || emp.nodeId == parentId
                select emp;

            return Ok(employeeQuery);
        }

        // GET api/Employees/5
        [ResponseType(typeof(Employee))]
        public async Task<IHttpActionResult> GetDepartment(int id)
        {
            Employee employee = await db.Employees.FindAsync(id);

            if (employee == null)
            {
                return NotFound();
            }

            string department = employee.department;

            IQueryable<Employee> employeeQuery =
                from emp in db.Employees
                where emp.department == department
                select emp;

            return Ok(employeeQuery);
        }

        // PUT api/Employees/5
        public async Task<IHttpActionResult> PutEmployee(int id, Employee employee)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != employee.id)
            {
                return BadRequest();
            }

            db.Entry(employee).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!EmployeeExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST api/Employees
        [ResponseType(typeof(Employee))]
        public async Task<IHttpActionResult> PostEmployee(Employee employee)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Employees.Add(employee);
            await db.SaveChangesAsync();

            return CreatedAtRoute("DefaultApi", new { id = employee.id }, employee);
        }

        // DELETE api/Employees/5
        [ResponseType(typeof(Employee))]
        public async Task<IHttpActionResult> DeleteEmployee(int id)
        {
            Employee employee = await db.Employees.FindAsync(id);
            if (employee == null)
            {
                return NotFound();
            }

            db.Employees.Remove(employee);
            await db.SaveChangesAsync();

            return Ok(employee);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool EmployeeExists(int id)
        {
            return db.Employees.Count(e => e.id == id) > 0;
        }
    }
}