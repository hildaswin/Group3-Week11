using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Group3.Data;
using Group3.Models;

namespace Group3.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ClassTablesController : ControllerBase
    {
        private readonly Group3_DatabaseContext _context;

        public ClassTablesController(Group3_DatabaseContext context)
        {
            _context = context;
        }

        // GET: api/ClassTables
        [HttpGet]
        public async Task<ActionResult<IEnumerable<ClassTable>>> GetClassTables()
        {
          if (_context.ClassTables == null)
          {
              return NotFound();
          }
            return await _context.ClassTables.ToListAsync();
        }

        // GET: api/ClassTables/5
        [HttpGet("{id}")]
        public async Task<ActionResult<ClassTable>> GetClassTable(int id)
        {
          if (_context.ClassTables == null)
          {
              return NotFound();
          }
            var classTable = await _context.ClassTables.FindAsync(id);

            if (classTable == null)
            {
                return NotFound();
            }

            return classTable;
        }

        // PUT: api/ClassTables/5
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPut("{id}")]
        public async Task<IActionResult> PutClassTable(int id, ClassTable classTable)
        {
            if (id != classTable.ClassId)
            {
                return BadRequest();
            }

            _context.Entry(classTable).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ClassTableExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/ClassTables
        // To protect from overposting attacks, see https://go.microsoft.com/fwlink/?linkid=2123754
        [HttpPost]
        public async Task<ActionResult<ClassTable>> PostClassTable(ClassTable classTable)
        {
          if (_context.ClassTables == null)
          {
              return Problem("Entity set 'Group3_DatabaseContext.ClassTables'  is null.");
          }
            _context.ClassTables.Add(classTable);
            await _context.SaveChangesAsync();

            return CreatedAtAction("GetClassTable", new { id = classTable.ClassId }, classTable);
        }

        // DELETE: api/ClassTables/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteClassTable(int id)
        {
            if (_context.ClassTables == null)
            {
                return NotFound();
            }
            var classTable = await _context.ClassTables.FindAsync(id);
            if (classTable == null)
            {
                return NotFound();
            }

            _context.ClassTables.Remove(classTable);
            await _context.SaveChangesAsync();

            return NoContent();
        }

        private bool ClassTableExists(int id)
        {
            return (_context.ClassTables?.Any(e => e.ClassId == id)).GetValueOrDefault();
        }
    }
}
