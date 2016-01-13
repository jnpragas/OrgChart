using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;

namespace OrgChartGoogle.Models
{
    public class Employee
    {
        [Key]
        public int id { get; set; }
        public string nodeId { get; set; }
        public string parentId { get; set; }
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string department { get; set; }
        public string jobTitle { get; set; }
        public string email { get; set; }
        public string phone { get; set; }
        public string image { get; set; }
    }
}