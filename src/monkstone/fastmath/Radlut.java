/* 
 * Copyright (c) 2015-16 Martin Prout
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * http://creativecommons.org/licenses/LGPL/2.1/
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
package monkstone.fastmath;

import org.jruby.Ruby;
import org.jruby.RubyFloat;
import org.jruby.RubyModule;
import org.jruby.anno.JRubyModule;
import org.jruby.anno.JRubyMethod;
import org.jruby.runtime.ThreadContext;
import org.jruby.runtime.builtin.IRubyObject;
import toxi.math.SinCosLUT;

/**
 *
 * @author Martin Prout
 */
@JRubyModule(name = "RadLut")
public class Radlut {

    static SinCosLUT lut;

    /**
     * Initialize sin table with values (first quadrant only)
     */
    public static final void initTable() {
        lut = SinCosLUT.getDefaultInstance();
    }

    /**
     *
     * @param runtime Ruby
     */
    public static void createRadlut(final Ruby runtime) {
        RubyModule radlutModule = runtime.defineModule("RadLut");
        radlutModule.defineAnnotatedMethods(Radlut.class);
        Radlut.initTable();
    }

    /**
     *
     * @param context ThreadContext
     * @param recv IRubyObject
     * @param other IRubyObject degrees
     * @return sin IRubyObject
     */
    @JRubyMethod(name = "sin", module = true)

    public static IRubyObject sin(ThreadContext context, IRubyObject recv, IRubyObject other) {
        RubyFloat thet = other.convertToFloat();
        double val = lut.sin(thet.getDoubleValue());
        return context.runtime.newFloat(val);
    }

    /**
     *
     * @param context ThreadContext
     * @param recv IRubyObject
     * @param other IRubyObject degrees
     * @return cos IRubyObject
     */
    @JRubyMethod(name = "cos", module = true)
    public static IRubyObject cos(ThreadContext context, IRubyObject recv, IRubyObject other) {
        RubyFloat thet = other.convertToFloat();
        double val = lut.cos(thet.getDoubleValue());
        return context.runtime.newFloat(val);
    }
}
