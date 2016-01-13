namespace OrgChartGoogle.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;
    using OrgChartGoogle.Models;

    internal sealed class Configuration : DbMigrationsConfiguration<OrgChartGoogle.Models.OrgChartGoogleContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
            ContextKey = "OrgChartGoogle.Models.OrgChartGoogleContext";
        }

        protected override void Seed(OrgChartGoogle.Models.OrgChartGoogleContext context)
        {
            //  This method will be called after migrating to the latest version.

            //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
            //  to avoid creating duplicate seed data. E.g.
            //
            //    context.People.AddOrUpdate(
            //      p => p.FullName,
            //      new Person { FullName = "Andrew Peters" },
            //      new Person { FullName = "Brice Lambson" },
            //      new Person { FullName = "Rowan Miller" }
            //    );
            //

            context.Employees.AddOrUpdate(x => x.id,
                new Employee()
                {
                    
                }
            );
        }
    }
}
