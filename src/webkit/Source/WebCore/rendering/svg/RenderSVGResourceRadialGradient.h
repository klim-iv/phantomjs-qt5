/*
 * Copyright (C) 2006 Nikolas Zimmermann <zimmermann@kde.org>
 * Copyright (C) Research In Motion Limited 2010. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public License
 * along with this library; see the file COPYING.LIB.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301, USA.
 */

#ifndef RenderSVGResourceRadialGradient_h
#define RenderSVGResourceRadialGradient_h

#if ENABLE(SVG)
#include "RadialGradientAttributes.h"
#include "RenderSVGResourceGradient.h"
#include "SVGRadialGradientElement.h"

namespace WebCore {

class SVGRadialGradientElement;

class RenderSVGResourceRadialGradient FINAL : public RenderSVGResourceGradient {
public:
    explicit RenderSVGResourceRadialGradient(SVGRadialGradientElement&);
    virtual ~RenderSVGResourceRadialGradient();

    SVGRadialGradientElement& radialGradientElement() const { return toSVGRadialGradientElement(RenderSVGResourceGradient::gradientElement()); }

    virtual RenderSVGResourceType resourceType() const { return s_resourceType; }
    static RenderSVGResourceType s_resourceType;

    virtual SVGUnitTypes::SVGUnitType gradientUnits() const { return m_attributes.gradientUnits(); }
    virtual void calculateGradientTransform(AffineTransform& transform) { transform = m_attributes.gradientTransform(); }
    virtual void buildGradient(GradientData*) const;

    FloatPoint centerPoint(const RadialGradientAttributes&) const;
    FloatPoint focalPoint(const RadialGradientAttributes&) const;
    float radius(const RadialGradientAttributes&) const;
    float focalRadius(const RadialGradientAttributes&) const;

private:
    void gradientElement() const WTF_DELETED_FUNCTION;

    virtual const char* renderName() const OVERRIDE { return "RenderSVGResourceRadialGradient"; }
    virtual bool collectGradientAttributes() OVERRIDE;

    RadialGradientAttributes m_attributes;
};

}

#endif
#endif
