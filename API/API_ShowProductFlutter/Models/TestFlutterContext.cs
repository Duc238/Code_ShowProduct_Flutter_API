using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace API_ShowProductFlutter.Models;

public partial class TestFlutterContext : DbContext
{
    public TestFlutterContext()
    {
    }

    public TestFlutterContext(DbContextOptions<TestFlutterContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Product> Products { get; set; }
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Products__3214EC079F6799B8");

            entity.Property(e => e.Price).HasColumnType("decimal(18, 0)");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
