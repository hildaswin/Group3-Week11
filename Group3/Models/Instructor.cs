﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace Group3.Models
{
    public partial class Instructor
    {
        public Instructor()
        {
            ClassTables = new HashSet<ClassTable>();
        }

        public int InstructorId { get; set; }
        public string InstructorFirstName { get; set; }
        public string InstructorMiddleName { get; set; }
        public string InstructorLastName { get; set; }
        public string InstructorEmpstatus { get; set; }
        public string InstructorPhone { get; set; }
        public string InstructorEmail { get; set; }

        public virtual ICollection<ClassTable> ClassTables { get; set; }
    }
}