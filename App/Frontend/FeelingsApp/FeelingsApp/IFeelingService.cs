using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FeelingsApp
{
    public interface IFeelingService
    {
        Feeling CurrentFeeling { get; set; }

    }
}
